{% snapshot orders_snapshot %}

{{
   config(
       target_schema='snapshots',
       unique_key='order_id',
       strategy='check',
       check_cols=['order_status','order_amount'],
       invalidate_hard_deletes=True
   )
}}

SELECT * FROM {{ source('raw_practice', 'orders') }}

{% endsnapshot %}