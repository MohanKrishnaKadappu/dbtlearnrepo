{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse = 'COMPUTE_WH',
        target_lag = 'DOWNSTREAM'
    )
}}

with item_dt as 
(
    SELECT *,
    
    ROW_NUMBER() OVER (PARTITION BY CUST_ID ORDER BY PRICE DESC) AS rn
    FROM {{ source('raw_layer','item') }}
)
select * from item_dt
where rn = 1    