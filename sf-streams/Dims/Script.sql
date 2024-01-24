USE VHOL_ST.PUBLIC;

CREATE OR REPLACE STAGE Products_Stage
FILE_FORMAT = ( TYPE=CSV );

CREATE OR REPLACE STAGE Customers_Stage
FILE_FORMAT = ( TYPE=CSV );

CREATE OR REPLACE TABLE Products (
product_id varchar,
product_name varchar,
category varchar,
price decimal(18,4)
);

CREATE OR REPLACE TABLE Customers (
customer_id varchar,
first_name varchar,
last_name varchar,
city varchar
);

CREATE OR REPLACE FILE FORMAT CSV_FORMAT 
type = csv 
field_delimiter = ',' 
skip_header = 1 
null_if = ('NULL', 'null') 
empty_field_as_null = true;

PUT file://C:\projects\realtime-dbt\realtime-dbt\analytics\seeds\customers.csv @Customers_Stage;
PUT file://C:\projects\realtime-dbt\realtime-dbt\analytics\seeds\products.csv @Products_Stage;

copy into Products from @Products_Stage file_format = (format_name = 'CSV_FORMAT');
copy into CUSTOMERS from @Customers_Stage file_format = (format_name = 'CSV_FORMAT');
