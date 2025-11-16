{{
    config(
        materialized='incremental',
        incremental_strategy='append'
        
    )
}}

SELECT 
    txn_id,
    account_id,
    txn_date,
    amount,
    txn_type,
    created_at
FROM {{ source('rawsource','bank_transactions_raw')}}