--if you can use 2-3 models to join the multipke (2/3 ref functions to create one model)
{{ config(materialized='table') }}
with customer as
(
select * from 
{{ ref('stg_customer') }}

),
orders as
(
 select * from {{ ref('stg_orders') }} 
),
   -- on c.c_custkey = o.o_custkey
nation as(
select * from {{ ref('stg_nation') }} 
),
 
   -- on c.c_nationkey = n.n_nationkey
joined_data as
(
    select 
    c.c_custkey as customer_key,    
    c.c_name as customer_name,
    c.c_address as customer_address,
    c.c_nationkey as customer_nationkey,
    n.n_nationkey as ref_nation_key,
    n.n_name as nation_name,
    replace(c.c_phone,'-','') as customer_phone,
    round(c.c_acctbal) as customer_acctbal,
    o.o_orderkey as order_key,
    o.o_orderstatus as order_status,
    o.o_totalprice as order_totalprice,
    o.o_orderdate as order_date,
    o.o_orderpriority as order_priority
    from customer c
    left join orders o
    on c.c_custkey = o.o_custkey
    left join nation n
    on c.c_nationkey = n.n_nationkey
)
select * from joined_data