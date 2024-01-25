CREATE OR REPLACE VIEW Reporting AS 
SELECT
product_name,
category,
city,
sum(price) AS total_price
FROM "CC_TRANS_ALL" 
GROUP BY "PRODUCT_NAME", "CATEGORY", "CITY";
