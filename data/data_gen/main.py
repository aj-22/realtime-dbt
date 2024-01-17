from entities import dims
from entities import facts

def load_dims():
    products = dims.generate_products(dims.products_data)
    customers = dims.generate_customers(120)
    dims.write_data(products,'.\\output','products.csv')
    dims.write_data(customers, '.\\output', 'customers.csv')

def transact():
    output_dir = '.\\output\\transactions\\'
    transaction = facts.TransactionUtility(10, output_dir)
    transaction.multi_write()

if __name__ == '__main__':
    # load_dims()
    transact()
