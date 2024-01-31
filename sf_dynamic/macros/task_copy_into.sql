
{% macro task_copy_into() %}

{% set sql %}
create or replace table "VHOL_ST"."DBT_DYNAMIC".STAGING (RECORD_CONTENT variant);
create or replace task "VHOL_ST".PUBLIC.PROCESS_FILES_DBT_DYNAMIC
USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE = 'XSMALL'
SCHEDULE = '1 minute'
COMMENT = 'Ingests Incoming Staging Datafiles into Staging Table'
as
copy into "VHOL_ST"."DBT_DYNAMIC".STAGING from @VHOL_STAGE PATTERN='.*file_.*';
execute task "VHOL_ST".PUBLIC.PROCESS_FILES_DBT_DYNAMIC;
{% endset %}

{% do run_query(sql) %}

{% endmacro %}