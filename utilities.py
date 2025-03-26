from datetime import datetime, timedelta, timezone
import sys
import io

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
