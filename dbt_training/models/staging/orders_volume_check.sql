--runtime logic
{{ config(materialized='ephemeral') }}
{% set count_query %}
    SELECT COUNT(*) AS row_count FROM 
    DEMO_DB.PUBLIC.ORDERS
{% endset %}

{% set result = run_query(count_query) %}  --run_query is dbt built in function to execute sql

/* result = {
columns
: [
    {
        name: 'ROW_COUNT',
        values: 4
    }
]
} */

{% if result %}
    {% set row_count = result.columns[0].values()[0] %}  --fetch values from python dictionary
    {% do log("Orders count: " ~ row_count, info=True) %}


    {% if row_count < 10 %}
        {{ send_email_notification(
            "ALERT: Low Orders Volume",
            "Orders table has only " ~ row_count ~ " rows today. Please check the pipeline."
        ) }}
    {% endif %}
{% endif %}