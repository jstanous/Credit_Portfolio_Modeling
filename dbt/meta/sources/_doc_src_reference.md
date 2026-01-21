{% docs source__credit_portfolio_ref %}  
Reference data used for modeling and reporting.  
{% enddocs %}  

<!---------------------------------->  
<!-- Loan Purpose Reference Table -->  
{% docs table__loan_purpose %}  
Mapping data for loan purposes to collateral types and exposure types.  

** Source: ** credit_portfolio.ref.loan_purpose  
** Grain: ** One record per loan purpose.  
{% enddocs %}  

{% docs column__collateral_type %}  
The underlying collateral securing the loans.  
Used to determine the Loss Given Default (LGD) rate for risk models.  

** Business Name: ** Collateral Type  
** Source: ** credit_portfolio.ref.loan_purpose.collateral_type  
** Values: **  
 - Property (Lien) — secured with lien on real property.  
 - Vehicle — secured by financed vehicle title.  
 - Asset-backed — secured by designated assets.  
 - Equipment — secured by equipment on real property.  
 - Business Assets — secured by underlying business assets.  
 - Unsecured — not secured by assets.  

** Use case: ** Identify the collateral type used to secure the loan.  
{% enddocs %}  

{% docs column__exposure_type %}  
The exposure type/asset class of the loans.  
Used to determine the Asset Correlation (R) for capital models.  

** Business Name: ** Exposure Type  
** Source: ** credit_portfolio.ref.loan_purpose.exposure_type  
** Values: **  
 - Personal Loan — Unsecured personal loan.  
 - Credit Card — Unsecured revolving line.  
 - Mortgage — Secured property loan.  
 - Retail SME — Secured small business loan.  

** Use case: ** Identify the exposure type for the loan.  
{% enddocs %}  


<!----------------------------------->  
<!-- Risk Segments Reference Table -->  
{% docs table__risk_segments %}  
Mapping data for credit grade to risk segments.  

** Source: ** credit_portfolio.ref.risk_segments  
** Grain: ** One record per credit grade.  
{% enddocs %}  

{% docs column__credit_grade %}  
The identifier for a credit grade.  

** Business Name: ** Credit Grade  
** Source: ** credit_portfolio.ref.risk_segments.credit_grade  

** Values: **  
 - Must be a valid single-character credit grade code (A - G).  
{% enddocs %}  

{% docs column__risk_segment %}  
The industry standard risk segment for the credit grade.  

** Business Name: ** Risk Segment  
** Source: ** credit_portfolio.ref.risk_segments.risk_segment  

** Values: **  
 - Is one of the following:
   - Super-Prime  
   - Prime  
   - Near-Prime  
   - Sub-Prime  
   - Deep Sub-Prime  
{% enddocs %}  

<!----------------------------->  
<!-- Regions Reference Table -->  
{% docs table__regions %}  
Mapping data for state to Bureau of Economic Analysis (BEA) division/region and Federal Reserve districts.  
For split state mappings, Federal Reserve districts are based on the largest population centers within each state.  

** Source: ** credit_portfolio.ref.regions  
** Grain: ** One record per state.  
{% enddocs %}  

{% docs column__state_cd %}  
Two‑character postal abbreviation for a state.  

** Business Name: ** State Code  
** Source: ** credit_portfolio.ref.regions.state_cd  

** Values: **  
 - Must be a valid 2 character state code  
{% enddocs %}  

{% docs column__division %}  
The BEA Division for the state.  

** Business Name: ** BEA Division  
** Source: ** credit_portfolio.ref.regions.division  
{% enddocs %}  

{% docs column__region %}  
The BEA Region for the state.  

** Business Name: ** BEA Region  
** Source: ** credit_portfolio.ref.regions.region  
{% enddocs %}  

{% docs column__fed_district %}  
The Federal Reserve Bank district id for the state.  

** Business Name: ** Federal Reserve District  
** Source: ** credit_portfolio.ref.regions.fed_district  
{% enddocs %}  

{% docs column__fed_district_name %}  
The Federal Reserve Bank district name for the state.  

** Business Name: ** Federal Reserve District Name  
** Source: ** credit_portfolio.ref.regions.fed_district_name  
{% enddocs %}  
