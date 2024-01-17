from faker import Faker
faker = Faker(locale='en_IN')
import random

products_data = {
    "house": ["detergent", "kitchen roll", "bin liners", "shower gel", "scented candles", "fabric softener",
              "cling film", "aluminium foil", "toilet paper", "kitchen knife", "dishwasher tablets", "ice pack"],
    "clothes": ["men's dark green trousers", "women's shoes", "jumper", "men's belt", "women's black socks",
                "men's striped socks", "men's trainers", "women's blouse", "women's red dress"],
    "fruit_veg": ["avocado", "cherries", "scotch bonnets", "peppers", "broccoli", "potatoes", "grapes",
                  "easy peeler", "mango", "lemon grass", "onions", "apples", "raspberries"],
    "sweets": ["carrot cake", "salted caramel dark chocolate", "gummy bears", "kombucha", "ice cream", "irn bru"],
    "food": ["steak", "chicken", "mince beef", "milk", "hummus", "activated charcoal croissant", "whole chicken",
             "tuna", "smoked salmon", "camembert", "pizza", "oats", "peanut butter", "almond milk", "lentil soup",
             "greek yoghurt", "parmesan", "coconut water", "chicken stock",  "water"],
    "bws": ["red wine", "gin", "cognac", "cigarettes"]
}


def id_generator(prefix='P'):
    id_number=1
    while True:
        yield prefix + str(id_number)
        id_number += 1


def generate_products(data):
    products = [(product, category) for category in data.keys() for product in data[category]]
    generator = id_generator()
    products_with_ids = [(product[0],product[1][0],product[1][1]) for product in zip(generator, products)]
    text='''product_id,product_name,category,price\n'''
    for product in products_with_ids:
        text += product[0] + ',' + product[1] + ',' + product[2] + ',' + str(random.randrange(10,200,5)) + '\n'
    return text


def generate_customers(number):
    text = '''customer_id,first_name,last_name,city\n'''
    for i in range(number):
        text += 'C' + str(i+1) + ',' + faker.first_name() + ',' + faker.last_name() + ',' + faker.city() + '\n'
    return text

def write_data(data, directory, file_name):
    with open(directory+'\\'+file_name, 'w') as f:
        f.write(data)

