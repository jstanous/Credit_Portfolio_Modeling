SELECT state_cd          AS state_code
     , fed_district      AS federal_reserve_district_id
     , fed_district_name AS federal_reserve_district_name
  FROM {{ source('credit_portfolio', 'regions') }}
