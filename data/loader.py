from database_connect.connection import SQL
from data_load.Watcher import Watch
import os

sql = SQL()
directory_to_watch = r'.\output\transactions'
cwd = os.getcwd()

def clean_json_files(folder):
    files = os.listdir(folder)
    for file in files:
        if file[-5:] = '.json':
            os.remove(file)

if __name__ == '__main__':
    print('Starting data-load...')
    watch = Watch(sql, directory_to_watch, cwd)
    watch.run() 

