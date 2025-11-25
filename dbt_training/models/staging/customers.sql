{{ 
config(
    materialized='table',
    schema='staging'
)
}}

select * from demo_db.public.customers