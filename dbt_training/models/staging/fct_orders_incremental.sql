{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='order_id'
        
    )
}}


--,database='raw',
--schema='ecommerce'
WITH joined as
(
    select 
        o.order_id,
        o.order_date,
        o.total_amount,
        o.customer_id,
        c.customer_name,
        c.customer_email
    FROM {{ ref('stg_orders') }} o
    JOIN {{ ref('stg_customers') }} c
        ON o.customer_id = c.customer_id
),

filtered as
(
    select *
    from joined
    --checks condition , if its icremental run , then only consider rows on/after the targets current max date
    {% if is_incremental() %}
        --only consider rows on/after the targets current max date
        WHERE order_date >= (
            SELECT COALESCE(MAX(order_date), '1900-01-01'::DATE) FROM {{ this }}
        )
    {% endif %}
)

SELECT *
FROM filtered

--initial run it will created , but 2nd time onwards incremental na , it will be merge