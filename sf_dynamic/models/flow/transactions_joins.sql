SELECT
'[' || s.transaction_id || '][' || s.customer_id || '][' || s.product_id || ']' AS row_id,
s.TRANSACTION_ID,
c."FIRST_NAME",
c."LAST_NAME",
C."CITY",
P."PRODUCT_NAME",
P."CATEGORY",
P."PRICE",
s.created_at AS created_at
FROM {{ ref('transactions_json_unload') }} s
LEFT JOIN {{ source('staging', 'PRODUCTS') }} P ON P."PRODUCT_ID" = S.Product_id
LEFT JOIN {{ source('staging', 'CUSTOMERS') }} C ON C."CUSTOMER_ID" = S.Customer_ID