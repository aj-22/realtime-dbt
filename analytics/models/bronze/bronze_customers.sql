select
customer_id,
first_name,
last_name,
city
from {{ source('source_data','customers') }}