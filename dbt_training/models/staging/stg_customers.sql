{{ config(materialized='view') }}

SELECT 
    o.customer_id,
    INITCAP(o.name) as customer_name,
    LOWER(o.email) as customer_email
FROM {{ source('ecommerce', 'raw_customers') }} o