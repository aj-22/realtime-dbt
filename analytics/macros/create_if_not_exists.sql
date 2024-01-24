{% macro create_if_not_exists(database, schema, table) %}

{%- set source_relation = adapter.get_relation(
      database=database,
      schema=schema,
      identifier=table) -%}

{% set table_exists=source_relation is not none  %}

{% if not table_exists %}
Create table {{database}}.{{schema}}.{{table}} (
  BulkColumn varchar(max),
  loaded_at datetime
)

{% endif %}

{% endmacro %}