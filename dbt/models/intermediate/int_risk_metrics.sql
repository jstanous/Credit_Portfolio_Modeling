{{ config(static_analysis = "off") }}

select
    member_id, 
--     , {{ get_pd("member_credit_subgrade") }} as pd
    credit_portfolio.udf.udf_get_pd(member_credit_subgrade) as pd
  from {{ ref('stg_members') }}
