{% snapshot customers_snapshot %}

{{
   config(
       target_schema='snapshots',
       unique_key='customer_id',
       strategy='timestamp',
       updated_at='updated_at',
       invalidate_hard_deletes=True
   )
}}

SELECT * FROM {{ source('raw_practice', 'customers') }}

{% endsnapshot %}