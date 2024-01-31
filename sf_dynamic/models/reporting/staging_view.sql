SELECT
RECORD_CONTENT:transaction_id::varchar transaction_id,
RECORD_CONTENT:customer_id::varchar customer_id,
RECORD_CONTENT:basket::Array basket,
RECORD_CONTENT:ts::DATETIME created_at
FROM {{ source('staging_table','staging') }}