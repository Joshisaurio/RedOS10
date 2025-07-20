from datetime import datetime, timedelta, timezone
import sys
import io
import os
import json
import threading
from profanityfilter import ProfanityFilter
import re

start_date = datetime(2000, 1, 1, tzinfo=timezone.utc)

FORMAT = "%Y-%m-%d %H:%M:%S"

def get_days_since_2000(date = None):
    if date is None:
        date = datetime.now(timezone.utc)
    return (date - start_date).total_seconds() / (24 * 60 * 60)

def get_date_str(days_since_2000):
	return (start_date + timedelta(days=float(days_since_2000))).replace(microsecond=0).strftime(FORMAT)

def get_now_str():
	return datetime.now(timezone.utc).replace(microsecond=0).strftime(FORMAT)

def get_second_diff(days_since_2000):
    return (datetime.now(timezone.utc) - (start_date + timedelta(days=float(days_since_2000)))).total_seconds()

def from_timestamp(timestamp: str):
    return datetime.strptime(timestamp, FORMAT).replace(tzinfo=timezone.utc)

def dont_print(func, *args, **kwargs):
    stdout_backup = sys.stdout  # Backup des originalen stdout
    sys.stdout = io.StringIO()  # Umleitung in einen "leeren" Output-Stream
    try:
        return func(*args, **kwargs)  # Funktion ausführen
    finally:
        sys.stdout = stdout_backup  # Wiederherstellen von stdout

class StorageBase(dict):

    parent: "StorageBase" = None

    def __init__(self, value: dict = {}, parent: "StorageBase" = None, *args, **kwargs):
        super().__init__(value, *args, **kwargs)
        if parent is not None:
            self.parent = parent
        else:
            if not isinstance(self, Storage):
                raise ValueError("parent should not be None")
    
    def load(self):
        for key, value in self.items():
            if isinstance(value, dict) and not isinstance(value, StorageBase):
                value = StorageBase(value=value, parent=self)
                self[key] = value
                value.load()

    def save(self):
        self.parent.save()

    def __setitem__(self, key, value):
        if isinstance(value, dict) and not isinstance(value, StorageBase):
            value = StorageBase(value=value, parent=self)
        super().__setitem__(key, value)
        self.save()

    def __delitem__(self, key):
        super().__delitem__(key)
        self.save()

    def update(self, *args, **kwargs):
        super().update(*args, **kwargs)
        self.save()

class Storage(StorageBase):
    filename: str
    interval_sec: timedelta

    _save_timer: threading.Timer = None

    def __init__(self, filename: str, interval_sec: int = 10, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.filename = filename
        self.interval_sec = timedelta(seconds=interval_sec)
        self.load()
        all_storage_instances.append(self)
    
    def load(self):
        try:
            if os.path.exists(self.filename):
                with open(self.filename, "r") as file:
                    self.update(json.load(file))
                    super().load()
        except (FileNotFoundError, json.decoder.JSONDecodeError):
            self.update({})
    
    def save_directly(self):
        with open(self.filename, "w") as file:
            json.dump(self, file)
        self._save_timer = None

    def save(self):
        if self._save_timer is None:
            self._save_timer = threading.Timer(self.interval_sec.total_seconds(), self.save_directly)
            self._save_timer.start()

all_storage_instances: list[Storage] = []

def save_all_storage_instances():
    for instance in all_storage_instances:
        if isinstance(instance, Storage):
            instance.save_directly()

def hash(number_str, B=31, M=100000000000031):
    hash_value = 0
    for digit in number_str:
        hash_value = (hash_value * B + int(digit)) % M
    return hash_value


pf = ProfanityFilter(no_word_boundaries=False)
pf.append_words(["profanitycheck"])

def is_profane(text: str):
    for char in "!\"#$%&'()*+,-./0123456789:;<=>?@[\\]^_`{|}~":
        text = text.replace(char, "")
    text = re.sub(r'\b(\w)\s+(?=\w\b)', r'\1', text)

    if pf.is_profane(text): return True

    return False

class RequestManager:
    _requests: dict
    _interval: timedelta
    _count: int

    def __init__(self, interval_sec: int = 60):
        self._requests = {}
        self._interval = timedelta(seconds=interval_sec)
        self._count = 0
    
    def check(self, data):
        self._count += 1
        if self._count > 100:
            self._clean_up()
            self._count = 0
        old_time, old_response = self._requests.get(data, (None, None))
        now = datetime.now()
        if old_time is not None:
            if now - datetime.fromtimestamp(old_time) < self._interval:
                return old_response
        self._requests[data] = (int(now.timestamp()), False)
        return None

    def set(self, data, response):
        self._count += 1
        if self._count > 100:
            self._clean_up()
            self._count = 0
        self._requests[data] = (int(datetime.now().timestamp()), response)

    def _clean_up(self):
        now = datetime.now()
        delete = []
        for data, (old_time, _) in self._requests.items():
            if now - datetime.fromtimestamp(old_time) > self._interval:
                delete.append(data)
        for data in delete:
            del self._requests[data]
