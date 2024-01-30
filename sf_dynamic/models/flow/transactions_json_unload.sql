SELECT
RECORD_CONTENT:transaction_id::varchar transaction_id,
RECORD_CONTENT:customer_id::varchar customer_id,
product.value::varchar product_id,
RECORD_CONTENT:ts::DATETIME created_at
FROM {{ source('staging','CC_TRANS_STAGING')}},
lateral flatten (RECORD_CONTENT:basket) product