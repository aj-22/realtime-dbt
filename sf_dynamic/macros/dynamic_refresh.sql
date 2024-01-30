{% macro dynamic_refresh(refresh_state) %}

{% if refresh_state in ['RESUME','resume','suspend','SUSPEND'] %}

{% set sql %}
    ALTER DYNAMIC TABLE {{ ref('transactions_json_unload') }} {{ refresh_state }};
    ALTER DYNAMIC TABLE {{ ref('transactions_joins') }} {{ refresh_state }};
{% endset %}

{% do run_query(sql) %}

{% do log( refresh_state + " Successful", info=True) %}

{% else %}

{% do log("Invalid Option", info=True) %}

{% endif %}

{% endmacro %}