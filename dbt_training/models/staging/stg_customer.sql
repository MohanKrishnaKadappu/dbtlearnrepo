{{config(materialized='view',secure=true)}}

with cte as
(
    select * from 
    Snowflake_sample_data.TPCH_SF1.CUSTOMER
)

select * from cte