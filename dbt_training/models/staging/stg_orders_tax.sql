{{ log_load('DEMO_DB.STAGING.STG_ORDERS_TAX') }}

with source as 
(
    select 
        order_id,
        customer_id,
        amount,
        {{ calc_tax('amount', 0.1) }}  --passing column name and tax rate 8 percent
    from {{ source('rawsource', 'orders') }}
)

select * 
from source