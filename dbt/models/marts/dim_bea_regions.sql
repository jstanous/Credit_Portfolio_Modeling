SELECT state_cd AS state_code
     , division AS bea_division
     , region AS bea_region
  FROM {{ source('credit_portfolio', 'regions') }}