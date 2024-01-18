import time
import sys

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

sys.path.append('..')
from database_connect.connection import SQL

class Handler(FileSystemEventHandler):
    def __init__(self, cwd):
        Handler.cwd = cwd

    @staticmethod
    def on_any_event(event):
        if event.is_directory:
            return None
        elif event.event_type == 'created':
            sql_obj = SQL()
            # Event is created, you can process it now
            path = Handler.cwd+event.src_path[1:]
            print("Received created event - % s." % path)
            sql_obj.load_json(path)
            del sql_obj


class Watch:
    def __init__(self, directory_to_watch, cwd):
        self.observer = Observer()
        self.directory_to_watch = directory_to_watch
        self.cwd = cwd

    def run(self):
        event_handler = Handler(self.cwd)
        self.observer.schedule(event_handler, self.directory_to_watch, recursive=False)
        self.observer.start()
        try:
            while True:
                time.sleep(2)
        except KeyboardInterrupt:
            self.observer.stop()
        self.observer.join()

