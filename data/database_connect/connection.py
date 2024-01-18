import pyodbc
import json
import random

class Password:
    def __init__(self, filepath=r'..\..\db_password.json'):
        with open(filepath, 'r') as f:
            contents = f.read()
        self.password = json.loads(contents)['password']
    def __del__(self):
        self.password = None


class SQL:
    def __init__(self, password = None):
        server = r'BOOK-8V0G45AGTL\MSSQLSERVER01'
        db = 'analytics'
        uid = 'sa'
        if password is None:
            pwd = Password().password
        else:
            pwd = password
        odbc_string = '''DRIVER={ODBC Driver 18 for SQL Server};SERVER=''' + server + \
                      ''';DATABASE=''' + db + ''';UID=''' + uid + ''';PWD=''' + pwd + \
                      ''';Trusted_Connection=yes;Encrypt=no;Integrated_Security=no'''
        self.conn = pyodbc.connect(odbc_string)
        self.cursor = self.conn.cursor()
        print("Connection established")

    def bulk_insert(self, tablename, filename):
        sql_statement='''bulk insert {} from '{}'
                    with (
                        FIRE_TRIGGERS,
                        FORMAT = 'CSV',
                        FIRSTROW = 2, 
                        FIELDTERMINATOR = ',', 
                        ROWTERMINATOR = '\n'
                    )'''.format(tablename, filename)
        self.cursor.execute(sql_statement)
        self.cursor.commit()

    def load_json(self, filename):
        sql_statement = '''
        INSERT INTO dbo.stg_transaction
        SELECT BulkColumn, current_timestamp as loaded_at
        FROM OPENROWSET(BULK '{}', SINGLE_CLOB) as j
        '''.format(filename)
        self.cursor.execute(sql_statement)
        self.cursor.commit()

    def get_random_dim(self, column_name, table_name):
        sql_statement='''SELECT ''' + column_name + ''' FROM ''' + str(table_name)
        self.cursor.execute(sql_statement)
        rows = [row[0] for row in self.cursor]
        return random.choice(rows)

    def __del__(self):
        self.conn.close()