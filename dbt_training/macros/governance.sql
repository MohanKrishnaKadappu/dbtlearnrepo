{%- macro sql_log_event(event) -%}
    -- Returns a single SQL statement for hooks to execute
    INSERT INTO DEMO_DB.AUDIT.MODEL_RUN_LOG (model_name, event, run_at, user_name)
    VALUES ('{{ this.identifier }}', '{{ event }}', CURRENT_TIMESTAMP, CURRENT_USER());
    --name of that mode [this.identifier], start/end event, current timestamp, current user
{%- endmacro %}


{%- macro sql_register_schema() -%}
    -- After the table exists, write its column list into the registry
    INSERT INTO DEMO_DB.GOVERNANCE.MODEL_SCHEMA_REGISTRY
        (database_name, schema_name, table_name, column_name, data_type, loaded_at)
    SELECT
        '{{ this.database }}'    AS database_name,
        '{{ this.schema }}'      AS schema_name,
        '{{ this.identifier }}'  AS table_name,
        column_name,
        data_type,
        CURRENT_TIMESTAMP
    FROM {{ this.database }}.INFORMATION_SCHEMA.COLUMNS
    WHERE table_schema = '{{ this.schema | upper }}'
      AND table_name = '{{ this.identifier | upper}}';
{%- endmacro %}
