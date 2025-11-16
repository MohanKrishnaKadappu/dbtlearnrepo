{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse = 'COMPUTE_WH',
        target_lag = 'DOWNSTREAM'
    )
}}

with customers_dt
as (
    select 
        cust_id,
        cust_name,
        outstanding_amt,
        CRID,
        location,
        cust_CREATED
    from {{ source('raw_layer','stg_customer') }} qualify row_number() 
    over (partition by cust_id order by cust_CREATED desc) = 1
)      
select * from customers_dt