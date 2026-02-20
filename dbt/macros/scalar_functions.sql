-- macros/scalar_functions.sql
-- Wrapper macros for Snowflake UDFs performing calculations (scalar functions)

-- Wrapper macro for Snowflake Term Weighted Average M UDF
-- Inputs:  Term Months, M Floor, M Ceiling
-- Returns: Remaining Maturity (m)
{% macro calc_m_twa(term_months, m_floor, m_ceiling) -%}
credit_portfolio.udf.udf_calc_m_twa({{ term_months }}, {{ m_floor }}, {{ m_ceiling }})
{%- endmacro %}

-- Wrapper macro for Snowflake b UDF
-- Inputs:  Remaining Maturity (m)
-- Returns: Maturity Sensitivity (b)
{% macro calc_b(m) -%}
credit_portfolio.udf.udf_calc_b({{ m }})
{%- endmacro %}

-- Wrapper macro for Snowflake RW UDF
-- Inputs:  Probability of Default (pd), Asset Correlation (r), Maturity Sensitivity (b)
-- Returns: Risk Weight (rw)
-- Notes:   Implements Basel III IRB risk weight formula
{% macro calc_rw(pd, r, b) -%}
credit_portfolio.udf.udf_calc_rw({{ pd }}, {{ r }}, {{ b }})
{%- endmacro %}

-- Wrapper macro for Snowflake K UDF
-- Inputs:  Loss Given Default (lgd), Risk Weight (rw)
-- Returns: Capital Factor (k)
-- Notes:   Implements Basel III IRB capital factor formula
{% macro calc_k(lgd, rw) -%}
credit_portfolio.udf.udf_calc_k({{ lgd }}, {{ rw }})
{%- endmacro %}
