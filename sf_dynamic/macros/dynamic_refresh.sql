{% macro dynamic_refresh(refresh_state) %}

{% if refresh_state in ['RESUME','SUSPEND','REFRESH'] %}

    {% if refresh_state == 'REFRESH' %}
        {% set sql %}
            EXECUTE TASK "VHOL_ST".PUBLIC.PROCESS_FILES_DBT_DYNAMIC;
        {% endset %}
        {% do run_query(sql) %}
    {% else %}
        {% set sql %}
            ALTER TASK "VHOL_ST".PUBLIC.PROCESS_FILES_DBT_DYNAMIC {{ refresh_state }};
        {% endset %}
        {% do run_query(sql) %}
    {% endif %}

    {% set sql %}
        ALTER DYNAMIC TABLE {{ ref('intermediate') }} {{ refresh_state }};
        ALTER DYNAMIC TABLE {{ ref('analytical') }} {{ refresh_state }};
    {% endset %}

    {% do run_query(sql) %}

    {% do log( refresh_state + " Successful", info=True) %}

{% else %}

    {% do log("Invalid Option", info=True) %}

{% endif %}

{% endmacro %}