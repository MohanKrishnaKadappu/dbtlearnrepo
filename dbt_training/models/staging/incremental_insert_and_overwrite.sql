{{
    config(
        materialized='incremental',
        incremental_strategy='insert_overwrite',
        partition_by={
            "field": "order_date",
            "data_type": "date"
        }
        
    )
}}

--DELETE INSERT WHEN YOU WILL USE , WHEN YOU WANT TO REFERESH A SUBSET IOF RULES
--MEANS N TARGET TABLE ONLY FEW ROWS TO BE REFRESHED INTEAD OF OLD DATA 
--DELETE DATA IN TARGET THEN INSERT FRESH DATA

SELECT 
    order_id,
    customer_id,
    order_date,
    amount
FROM {{ source('rawsource', 'raw_orders') }}

{% if is_incremental() %}
    WHERE order_date >=  dateadd(day, -3, current_date)
        -- IMP : FILER USES MAX(TXN_DATE) FROM THE TARGET TABLE ITSELF {{ this }}

        --SELECT COALESCE(MAX(TXN_DATE), '1900-01-01'::DATE) FROM {{ this }}
        --SUPPPOSE YOUR REQ CHANGES , DELETE INSERT BASED ON LAST 3 DAYS
        --WHERE TXN_DATE >= DATEADD(DAY, -3, (SELECT MAX(TXN_DATE) FROM {{ this }}))
        --SUPPPOSE YOUR REQ CHANGES , DELETE INSERT BASED ON LAST 1 MONTHS
        --WHERE TXN_DATE >= DATEADD(MONTH, -1, (SELECT MAX(TXN_DATE) FROM {{ this }}))
{% endif %}