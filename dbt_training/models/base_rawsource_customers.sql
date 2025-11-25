with source as (
        select * from {{ source('rawsource', 'customers') }}
  ),
  renamed as (
      select
          {{ adapter.quote("CUST_ID") }},
        {{ adapter.quote("NAME") }},
        {{ adapter.quote("EMAIL") }},
        {{ adapter.quote("COUNTRY") }}

      from source
  )
  select * from renamed
    