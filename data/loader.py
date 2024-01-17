from database_connect.connection import SQL
from data_load.Watcher import Watch
import os

sql = SQL()
directory_to_watch = r'.\output\transactions'
cwd = os.getcwd()

if __name__ == '__main__':
    print('Starting data-load...')
    watch = Watch(sql, directory_to_watch, cwd)
    watch.run()