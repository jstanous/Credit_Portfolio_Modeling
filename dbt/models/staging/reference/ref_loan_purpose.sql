SELECT loan_purpose
     , collateral_type
     , exposure_type
  FROM {{source('credit_portfolio', 'loan_purpose') }}
