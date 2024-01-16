with current_view as (
select 
transaction_id,
first_name,
last_name,
city,
product_name,
category,
price
from {{ ref('silver_details_curr') }}
where {{ convert_tz_to_UTC('loaded_at') }} >= '{{ run_started_at }}'
),

historical_table as (
select 
transaction_id,
first_name,
last_name,
city,
product_name,
category,
price
from {{ ref('silver_details_hist') }}
where {{ convert_tz_to_UTC('loaded_at') }} < '{{ run_started_at }}'
),
unioned_tables as (

select * from current_view

union all

select * from historical_table

)
select * from unioned_tables