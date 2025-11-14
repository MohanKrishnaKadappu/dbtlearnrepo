{{ config(materialized='ephemeral') }}

with cte as
(
    select * from 
    Snowflake_sample_data.TPCH_SF1.ORDERS
)

select * from cte