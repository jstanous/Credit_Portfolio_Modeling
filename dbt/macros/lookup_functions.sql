-- macros/lookup_functions.sql
-- Wrapper macros for Snowflake UDFs performing lookups against reference data

-- Wrapper macro for Snowflake COF Rate UDF
-- Inputs:  Pricing Date, Pricing Term
-- Returns: Cost Of Funds Rate (cof_rate)
{% macro get_cof_rate(pricing_date, pricing_term) -%}
credit_portfolio.udf.udf_get_cof_rate({{ pricing_date }}, {{ pricing_term }})
{%- endmacro %}

-- Wrapper macro for Snowflake LGD UDF
-- Inputs:  Collateral Type
-- Returns: Loss Given Default (lgd)
{% macro get_lgd(collateral_type) -%}
credit_portfolio.udf.udf_get_lgd({{ collateral_type }})
{%- endmacro %}

-- Wrapper macro for Snowflake PD UDF
-- Inputs:  Credit Subgrade
-- Returns: Probability of Default (pd)
{% macro get_pd(subgrade) -%}
credit_portfolio.udf.udf_get_pd({{ subgrade }})
{%- endmacro %}

-- Wrapper macro for Snowflake R UDF
-- Inputs:  Exposure Type, PD
-- Returns: Asset Correlation (r)
-- Notes:   Hybrid logic - 'Retail SME' exposures are calculated, lookups for other exposures.
{% macro get_r(exposure_type, pd) -%}
credit_portfolio.udf.udf_get_r({{ exposure_type }}, {{ pd }})
{%- endmacro %}
