select member_id
     , {{ get_pd('member_credit_subgrade') }} as pd
  from {{ ref('stg_members') }}
