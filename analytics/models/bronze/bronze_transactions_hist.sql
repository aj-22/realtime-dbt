with cte as (
select
JSON_VALUE(BulkColumn, '$.transaction_id') AS transaction_id,
JSON_VALUE(BulkColumn, '$.customer_id') AS customer_id,
basket.value as product_id,
JSON_VALUE(BulkColumn, '$.ts') AS transaction_ts,
loaded_at
from {{ source('source_data', 'stg_transaction')}}
outer apply OPENJSON(stg_transaction.BulkColumn, '$.basket') basket
{{ lambda_filter('loaded_at') }}
)
select
{{ create_row_id(['transaction_id','customer_id','product_id']) }} as row_id,
transaction_id,
customer_id,
product_id,
transaction_ts,
loaded_at
from cte