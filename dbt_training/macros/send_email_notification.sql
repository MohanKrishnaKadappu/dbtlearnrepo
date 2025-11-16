{% macro send_email_notification(subject, body) %}

    {% set sql %}
        CALL SYSTEM$SEND_EMAIL(
            'EMAIL_ALERT_INT',             -- Email integration name
            'mohan.krishna.k@gds.ey.com',   -- Recipient email
            '{{ subject | replace("\"", "\"\"") }}',
            '{{ body | replace("\"", "\"\"") }}'
        )
    {% endset %}

    {% do log("Sending Email -> " ~ subject, info=True) %} --display output on cli
    {% do run_query(sql) %}
{% endmacro %}
