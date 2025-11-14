{{ config(materialized='ephemeral') }}

with cte as
(
    select * from 
    Snowflake_sample_data.TPCH_SF1.CUSTOMER
)

select * from cte