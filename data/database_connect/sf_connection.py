import snowflake.connector
import json
import random

class Password:
    def __init__(self, filepath=r'..\..\sf_password.json'):
        with open(filepath, 'r') as f:
            contents = f.read()
        self.password = json.loads(contents)['password']
    def __del__(self):
        self.password = None

class SF:
    def __init__(self):
        self.conn = snowflake.connector.connect(
            user="FIRSTDATA",
            password=Password().password,
            account="lwloesd-fb56651",
            warehouse="VHOL_WH",
            database="VHOL_ST",
            schema="PUBLIC"
        )
        self.cur = self.conn.cursor()
        self.cur.execute('Use role VHOL')
        self.cur.execute('Use database VHOL_ST')
        print("Connection Established")

    def __del__(self):
        self.cur.close()
        self.conn.close()

    def execute_sql(self, sql_string):
        self.cur.execute(sql_string)
    
    def get_results(self, sql_string):
        self.cur.execute(sql_string)
        query_id = self.cur.sfqid
        self.cur.get_results_from_sfqid(query_id)
        results = self.cur.fetchall()
        return results[0]
    
    def put(self, filepath, stage='@VHOL_STAGE'):
        sql_string = r'''PUT file://''' + filepath + ''' ''' + stage
        self.cur.execute(sql_string)
