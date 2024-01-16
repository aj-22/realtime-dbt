select
t.row_id,
t.transaction_id,
c.first_name,
c.last_name,
c.city,
p.product_name,
p.category,
p.price,
t.loaded_at
from {{ ref('bronze_transactions_hist') }} t
left join {{ ref('bronze_products') }} p on t.product_id = p.product_id
left join {{ ref('bronze_customers') }} c on t.customer_id = c.customer_id