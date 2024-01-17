from data_gen.entities import dims
from data_gen.entities import facts
from database_connect.connection import SQL

sql = SQL()

def load_dims():
    products = dims.generate_products(dims.products_data)
    customers = dims.generate_customers(120)
    dims.write_data(products,'.\\output','products.csv')
    dims.write_data(customers, '.\\output', 'customers.csv')

def transact(number = 5, sql = sql):
    output_dir = '.\\output\\transactions\\'
    transaction = facts.TransactionUtility(number, output_dir, sql)
    transaction.multi_write()

if __name__ == '__main__':
    # load_dims()
    transact()