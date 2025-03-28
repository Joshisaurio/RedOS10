from datetime import datetime, timedelta, timezone
import sys
import io
import os
import json
import threading
from collections import UserDict

start_date = datetime(2000, 1, 1)

FORMAT = "%Y-%m-%d %H:%M:%S"

# def get_days_since_2000(date_str: str):
# 	return datetime.strptime(date_str, FORMAT) - start_date.total_seconds() / (24 * 60 * 60)

def get_date_str(days_since_2000):
	return (start_date + timedelta(days=float(days_since_2000))).replace(microsecond=0).strftime(FORMAT)

def get_now_str():
	return datetime.now(timezone.utc).replace(microsecond=0).strftime(FORMAT)


def dont_print(func, *args, **kwargs):
    stdout_backup = sys.stdout  # Backup des originalen stdout
    sys.stdout = io.StringIO()  # Umleitung in einen "leeren" Output-Stream
    try:
        return func(*args, **kwargs)  # Funktion ausführen
    finally:
        sys.stdout = stdout_backup  # Wiederherstellen von stdout


class Storage(dict):
    filename: str
    intervall_sec: int

    _last_save_time: datetime = None
    _save_timer: threading.Timer = None

    def __init__(self, filename: str, intervall_sec: int = 60, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.filename = filename
        self.intervall_sec = timedelta(seconds=intervall_sec)
        self.load()
        all_storage_instances.append(self)
    
    def load(self):
        try:
            if os.path.exists(self.filename):
                with open(self.filename, "r") as file:
                    self.update(json.load(file))
        except (FileNotFoundError, json.decoder.JSONDecodeError):
            self.update({})
    
    def save_directly(self):
        with open(self.filename, "w") as file:
            json.dump(self, file)
        self._last_save_time = datetime.now()
        self._save_timer = None

    def save(self):
        current_time = datetime.now()
        if self._last_save_time is None or current_time - self._last_save_time > self.intervall_sec:
            self.save_directly()
        else:
            if self._save_timer is None:
                _delayed_save_timer = threading.Timer(self.intervall_sec.total_seconds(), self.save_directly)
                _delayed_save_timer.start()
    
    def __setitem__(self, key, value):
        super().__setitem__(key, value)
        self.save()

    def __delitem__(self, key):
        super().__delitem__(key)
        self.save()

    def update(self, *args, **kwargs):
        super().update(*args, **kwargs)
        self.save()

all_storage_instances: list[Storage] = []

def save_all_storage_instances():
    for instance in all_storage_instances:
        if isinstance(instance, Storage):
            instance.save_directly()
