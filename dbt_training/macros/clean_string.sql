{% macro clean_string(col) %}  --syntax- macro and name of your function , accepting one input arg
    TRIM(UPPER({{ col }}))  --convert input arg to upper case and trim spaces
{% endmacro %}