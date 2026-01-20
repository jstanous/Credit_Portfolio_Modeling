select customer_id
     , {{ get_PD('customer_credit_subgrade') }} as pd
  from {{ ref('stg_customers') }}
