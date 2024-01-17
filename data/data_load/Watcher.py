import time

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class Handler(FileSystemEventHandler):
    sql = None
    def __init__(self, sql, cwd):
        Handler.sql = sql
        Handler.cwd = cwd

    @staticmethod
    def on_any_event(event):
        if event.is_directory:
            return None
        elif event.event_type == 'created':
            # Event is created, you can process it now
            print("Received created event - % s." % event.src_path)
            Handler.sql.load_json(Handler.cwd+event.src_path[1:])


class Watch:
    def __init__(self, sql, directory_to_watch, cwd):
        self.observer = Observer()
        self.sql = sql
        self.directory_to_watch = directory_to_watch
        self.cwd = cwd

    def run(self):
        event_handler = Handler(self.sql, self.cwd)
        self.observer.schedule(event_handler, self.directory_to_watch, recursive=False)
        self.observer.start()
        try:
            while True:
                time.sleep(2)
        except KeyboardInterrupt:
            self.observer.stop()
        self.observer.join()


if __name__ == '__main__':
    print('Starting data-load...')
    watch = Watch()
    watch.run()
