{{ config(materliazed='table',schema='staging') }}

with ranked_claims as (
    select
        *,
        row_number() over (
            partition by EMPLOYEE_ID
            order by CLAIM_DATE desc
        ) as rn
    from RAW.PUBLIC.EXPENSE_CLAIMS
)

SELECT 
    CLAIM_ID, 
    EMPLOYEE_ID,
    CLAIM_DATE,
    UPPER(EXPENSE_TYPE) AS EXPENSE_TYPE,
    CLAIMED_AMOUNT,
    CURRENCY,
    LOWER(APPROVAL_STATUS) AS APPROVAL_STATUS,
    APPROVER_ID
FROM ranked_claims
WHERE rn = 1

--please use a standard macro generate schema name
--by default you create a object , it will create a view itself
