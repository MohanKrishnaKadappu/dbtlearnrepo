{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse = 'COMPUTE_WH',
        target_lag = '1 MINUTES'
    )
}}

WITH CUST_ITEM_DT AS 
(
    SELECT 
        c.cust_id,
        c.cust_name,
        c.crid,
        c.location,
        c.cust_created,
        i.item_id,
        i.item_category,
        i.price,
        i.counts,
        ROUND(i.price / i.counts,2) AS price_per_item
        
    FROM {{ref('customer_dt')}} c
   INNER JOIN {{ref('item_dt')}} i
    ON c.cust_id = i.cust_id
)
select * from CUST_ITEM_DT

--https://cloudyard.in/2025/08/building-iceberg-tables-in-snowflake-macros-vs-native-support/