create or replace stream CC_TRANS_STAGING_VIEW_STREAM on view CC_TRANS_STAGING_VIEW SHOW_INITIAL_ROWS=true;


create or replace task PROCESS_FILES_TASK
USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
SCHEDULE = '1 minute'
COMMENT = 'Ingests Incoming Staging Datafiles into Staging Table'
as
copy into CC_TRANS_STAGING from @VHOL_STAGE PATTERN='.*file_.*';

execute task PROCESS_FILES_TASK;

SELECT * FROM CC_TRANS_STAGING_VIEW_STREAM;

create or replace table CC_TRANS_ALL (
row_id varchar,
transaction_id varchar,
first_name varchar,
last_name varchar,
city varchar,
product_name varchar,
category varchar,
price varchar,
loaded_at datetime
);

create or replace task REFINE_TASK
USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
SCHEDULE = '1 minute'
COMMENT = '2.  ELT Process New Transactions in Landing/Staging Table into a more Normalized/Refined Table (flattens JSON payloads)'
when
SYSTEM$STREAM_HAS_DATA('CC_TRANS_STAGING_VIEW_STREAM')
as
insert into CC_TRANS_ALL (
SELECT
'[' || s.transaction_id || '][' || s.customer_id || '][' || s.product_id || ']' AS row_id,
s.TRANSACTION_ID,
c."FIRST_NAME",
c."LAST_NAME",
C."CITY",
P."PRODUCT_NAME",
P."CATEGORY",
P."PRICE",
s.TS AS Loaded_at
FROM 
(select                     
TRANSACTION_ID, CUSTOMER_ID, product.value AS PRODUCT_ID, ts
from CC_TRANS_STAGING_VIEW_STREAM,
lateral flatten (basket) product) s
LEFT JOIN Products P ON P."PRODUCT_ID" = S.Product_id
LEFT JOIN CUSTOMERS C ON C."CUSTOMER_ID" = S.Customer_ID
);

EXECUTE TASK refine_task;

select * from CC_TRANS_ALL;