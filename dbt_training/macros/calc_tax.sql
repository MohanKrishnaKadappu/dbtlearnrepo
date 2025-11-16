{% macro calc_tax(amount_column, tax_rate=0.1) %}  --tax_rate 10 percent
    ({{ amount_column }} * {{ tax_rate }}) as TAX_AMOUNT,
    ({{ amount_column }} * (1 + {{ tax_rate }})) as TOTAL_AMOUNT
{% endmacro %}