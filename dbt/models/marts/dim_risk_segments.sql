SELECT credit_grade
     , risk_segment
  FROM {{ source('credit_portfolio', 'risk_segments') }}