{% macro log_load(table_name) %}
    {% if execute %}
        {% set sql %}

            insert into DEMO_DB.AUDIT.LOAD_LOG(table_name, row_count, loaded_at)
            select
                '{{ table_name }}' as tbl_name,
                count(*) as cnt,
                current_timestamp
            from {{ table_name }}

        {% endset %}

        {% do run_query(sql) %}
    {% endif %}

    {# intentionally return nothing #}
{% endmacro %}