{{
    config(
        materialized='table',
        pre_hook="{{ sql_log_event('start') }}",
        post_hook=[
        "{{ sql_log_event('end') }}",
        "{{ sql_register_schema() }}"
        ]
    )
}}

SELECT 
    customer_id, 
    SUM(amount) as total_amount,
    count(*) AS order_count,
    count(*) as demo_new_count
FROM demo_db.raw.ORDERS
GROUP BY customer_id