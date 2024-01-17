import json
import uuid
from datetime import datetime
import time
import random

class Transaction:
    def __init__(self, sql):
        self.sql = sql

    def generate_basket(self):
        number = random.randint(1,6)
        basket=[]
        for i in range(number):
            product = self.sql.get_random_dim("product_id", "dbo.products")
            basket.append(product)
        return basket

    def generate_transaction(self):
        customer_id = self.sql.get_random_dim("customer_id","dbo.customers")
        return {
            'transaction_id' : str(uuid.uuid4()),
            'customer_id': customer_id,
            'basket': self.generate_basket(),
            'ts': str(datetime.now())
        }

class TransactionUtility:
    def __init__(self, number, output_dir, sql):
        self.number = number
        self.output_dir = output_dir
        self.transaction = Transaction(sql)

    def write_transaction(self):
        t = self.transaction.generate_transaction()
        with open(self.output_dir + '\\file_' + str(int(time.time())) + '.json', 'w') as f:
            f.write(json.dumps(t))
        sleep_time = random.randint(1,5)
        time.sleep(sleep_time)

    def multi_write(self):
        for i in range(self.number):
            self.write_transaction()
