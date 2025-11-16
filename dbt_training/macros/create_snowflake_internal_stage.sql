{% macro create_snowflake_internal_stage(db, schema, name, file_format='') %}

    {% if file_format %}
        {% set format_clause = "FILE_FORMAT = (" ~ file_format ~ ")" %}
    {% else %}
        {% set format_clause = "" %}
    {% endif %}

    {% set sql %}
        CREATE OR REPLACE STAGE {{ db }}.{{ schema }}.{{ name }}
        {{ format_clause }}
    {% endset %}

    {% do log("Executing SQL: " ~ sql, info=True) %}
    {{ run_query(sql) }}

{% endmacro %}
