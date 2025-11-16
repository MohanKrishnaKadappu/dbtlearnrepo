{{
    config(
        materialized='table',
        pre_hook="""
            INSERT INTO demo_db.PUBLIC.audit_logs (model_name, event, run_at,user_name)
            VALUES ('stg_audit_customers_model', 'start', CURRENT_TIMESTAMP, CURRENT_USER());
        """,
        post_hook="""
            INSERT INTO demo_db.PUBLIC.audit_logs (model_name, event, run_at,user_name)
            VALUES ('stg_audit_customers_model', 'end', CURRENT_TIMESTAMP, CURRENT_USER());
        """
    )
}}

SELECT id, COUNT(*) as order_count
FROM demo_db.PUBLIC.CUSTOMERS_RAW
GROUP BY id