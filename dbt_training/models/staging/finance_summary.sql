{{ config(
    materialized='table',
    post_hook="""
        GRANT SELECT ON {{ this }} TO ROLE ANALYST_FR;
    """
) }}

select id,
count(*) as txn_count
from demo_db.public.CUSTOMERS_RAW
group by id