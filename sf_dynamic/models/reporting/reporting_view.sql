SELECT
product_name,
category,
city,
sum(price) AS total_price
FROM {{ ref('analytical') }}
GROUP BY "PRODUCT_NAME", "CATEGORY", "CITY"