from database_connect.sf_connection import SF
from data_load.SF_Watcher import Watch
import os

def test_database():
    sf = SF()
    sf.execute_sql("Create table test_table(col1 integer)")
    sf.execute_sql("Insert into test_table values(1)")
    print(sf.get_results("Select * from test_table"))

def test_put():
    sf = SF()
    sf.put(filepath=r'C:\projects\realtime-dbt\realtime-dbt\data\output\transactions\file_1705574221.json')

def clean_json_files(folder=r'.\output\transactions'):
    files = os.listdir(folder)
    for file in files:
        if file[-5:] == '.json':
            os.remove(os.getcwd()+folder[1:] + '\\' + file)

if __name__ == '__main__':
    print('Starting data-load...')
    directory_to_watch = r'.\output\transactions'
    cwd = os.getcwd()
    watch = Watch(directory_to_watch, cwd)
    watch.run()
