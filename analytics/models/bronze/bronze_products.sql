select
product_id,
product_name,
category,
price
from {{ source('source_data','products') }}