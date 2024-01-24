select 
'Bronze' as Layer, 
coalesce( (select count(*) from {{ ref('bronze_transactions_curr') }}), 0 ) as Fresh_Count,
(select count(*) from {{ ref('bronze_transactions_hist') }} ) as Historical_Count,
0 as Lambda_Count

union all

select 
'Silver' as Layer, 
coalesce( (select count(*) from {{ ref('silver_details_curr') }}), 0 ) as Fresh_Count,
(select count(*) from {{ ref('silver_details_hist') }} ) as Historical_Count,
0 as Lambda_Count

union all

select 
'Gold' as Layer, 
0 as Fresh_Count,
0 as Historical_Count,
(select count(*) from {{ ref('gold_union') }} ) as Lambda_Count

