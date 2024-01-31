{% macro view_on_stage() %}

{% set sql %}
    USE SCHEMA PUBLIC;
    CREATE OR REPLACE VIEW VHOL_STAGE_VIEW AS
    SELECT * FROM '@VHOL_STAGE';
{% endset %}

{% do run_query(sql) %}

{% endmacro %}