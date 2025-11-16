{{ config(materialized='ephemeral') }}
{% set stage_name = 'my_dbt_first_stage' %}
{% set db= 'demo_db' %}
{% set schema= 'public' %}
{% set file_format= "TYPE = CSV SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY='\"'" %}


--call the macro to create internal stage
{{ create_snowflake_internal_stage(
    db=db,
    schema=schema,
    name=stage_name,
    file_format=file_format
    ) 
}}

SELECT 'Stage created successfully' as status