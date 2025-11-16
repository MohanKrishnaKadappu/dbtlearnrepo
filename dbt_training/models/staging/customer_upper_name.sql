select 
--pass the name of macro and input arg ...col is column name
    {{ clean_string('first_name') }} as first_name_clean,
    {{ clean_string('last_name') }} as last_name_clean,
    lower(email) as email,
    initcap(country) as country_Clean
from {{ source('rawsource', 'customers') }}