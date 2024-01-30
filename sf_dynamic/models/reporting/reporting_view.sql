SELECT
product_name,
category,
city,
sum(price) AS total_price
FROM {{ ref('transactions_joins') }}
GROUP BY "PRODUCT_NAME", "CATEGORY", "CITY"