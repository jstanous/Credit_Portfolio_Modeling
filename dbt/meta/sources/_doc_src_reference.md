{% docs source__credit_portfolio_ref %}  
Reference data used for modeling and reporting
{% enddocs %}  

{% docs table__loan_purpose %}  
Mapping data for Loan Purposes to Collateral Types and Exposure Types.  

** Source: ** ref.loan_purpose  
** Grain: ** One record per loan purpose.  
{% enddocs %}  

{% docs column__collateral_type %}  
The underlying collateral securing the loans.  
Used to determine the Loss Given Default rate for risk models.

** Business Name: ** Collateral Type  
** Source: ** loan_purpose.collateral_type  
** Values: **  
 - Property (Lien) — secured with lien on real property.  
 - Vehicle — secured by financed vehicle title.  
 - Asset-backed — secured by designated assets.  
 - Equipment — secured by equipment on real property.  
 - Business Assets — secured by underlying business assets.  
 - Unsecured — not secured by assets.  

** Use case: ** Indentify the collateral type used to secure the loan.  
{% enddocs %}  

{% docs column__exposure_type %}  
The exposure type/asset class of the loans.  
Used to determine the Asset Correlation for risk models.

** Business Name: ** Exposure Type  
** Source: ** loan_purpose.exposure_type  
** Values: **  
 - Personal Loan — Unsecured personal loan.  
 - Credit Card — Unsecured revolving line.
 - Mortgage — Secured property loan.
 - Retail SME — Secured small business loan.

** Use case: ** Indentify the exposure type for the loan.  
{% enddocs %}  
