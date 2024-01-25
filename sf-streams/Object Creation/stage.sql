create or replace stage VHOL_STAGE
FILE_FORMAT = ( TYPE=JSON,STRIP_OUTER_ARRAY=TRUE );

create or replace table CC_TRANS_STAGING (RECORD_CONTENT variant);


--list @VHOL_STAGE pattern='.*file_.*';

--copy into CC_TRANS_STAGING from @VHOL_STAGE PATTERN='.*file_.*';

create or replace view 
CC_TRANS_STAGING_VIEW (transaction_id, customer_id, basket, created_at ) 
as (
SELECT
RECORD_CONTENT:transaction_id::varchar transaction_id,
RECORD_CONTENT:customer_id::varchar customer_id,
RECORD_CONTENT:basket::ARRAY basket,
RECORD_CONTENT:ts::DATETIME created_at
FROM "CC_TRANS_STAGING");

--,
--lateral flatten (RECORD_CONTENT:basket, OUTER => TRUE) product_id)


alter table CC_TRANS_STAGING set CHANGE_TRACKING = true;
alter view CC_TRANS_STAGING_VIEW set CHANGE_TRACKING = true;

-- SELECT * FROM CC_TRANS_STAGING_VIEW;
