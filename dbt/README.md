# Credit Portfolio Modeling: Capital & Profitability

## Overview

This project delivers a validated credit portfolio model aligned with Retail Basel III IRB and profitability frameworks. It integrates funding costs, capital formation, risk‑weighted asset logic, and profitability attribution across 38,000+ loans. The model evaluates lifetime loan performance based on origination attributes.

## Attribution

Foundational loan records were sourced from the [Loan Portfolio Analysis](https://github.com/arahm071/Loan-Portfolio-Analysis) repository.  
All modeling logic, enhancements, and capital/profitability overlays are original to this project.

## Objectives

- Evaluate loan performance during the 2021 recovery period.
- Assess pricing efficiency and capital usage across exposure types and credit grades.
- Model profitability, capital requirements, and risk-adjusted returns using annualized metrics.

## Context

In 2021, the U.S. economy emerged from pandemic disruption. Stimulus policies and low interest rates boosted liquidity and borrowing. This project examines how those conditions shaped loan performance, with emphasis on risk attribution and profitability.

## Disclaimer  

This framework is intended solely for internal profitability modeling and scenario analysis, and does not reflect, replace, or satisfy regulatory reporting requirements.

## Model Overview

- **Model Inputs**  
  - **Source Data**  
    Loan-level records: Term, Amount, Interest Rate, Origination Date, Credit Grade, and Purpose  
  - **Lookup Tables**  
    - Cost Of Funds (COF) Rates  
    - Probability of Default (PD)  
    - Collateral/Exposure Types  
    - Loss Given Default (LGD)  
    - Asset Correlation (R)  
    - Rate Assertions

- **Assumptions**  
  - **Loan Handling**  
    - All loans are assumed to be fully funded and normally amortizing with payments following scheduled amortization.  
    - Interest rates and credit grades are treated as fixed at origination; repricing, refinancing, and credit migration effects are not modeled.  
    - Prepayment, delinquency, and default events are not observed.
  - **Rate Assertions**  
    - **Synthetic Cost Of Funds (COF) Curves**  
      Funding cost curves were constructed using best available data to approximate market conditions.  
      See [Cost of Funds Curve Construction](docs/CostOfFundsCurveConstruction.md)
    - **Credit Grade to Probability of Default (PD)**  
      Credit subgrades were mapped to PD using FICO-based approximations to reflect risk exposure.
    - **Other Rates**  
      Other rates align to regulatory requirements or reflect industry averages for 2021.  
      See Data Dictionary: Rates and Factors for details
- **Exclusions**
  - **Unused Commitment**  
    Unused commitment is not modeled in this framework. The portfolio is treated as fully funded at origination, with no consideration of undrawn lines or contingent exposures.
  - **Credit Conversion Factor (CCF)**  
    CCF adjustments are not applicable in this model. All exposures are assumed to be fully funded, and no off‑balance sheet conversion is applied.
- **Features**
  - **Matched-Maturity Cost Of Funds (MMCOF)**  
    Funding costs are allocated using term-matched rates specific to each loan's origination date.
  - **Basel III Alignment**  
    Implements the Basel III Internal Ratings‑Based (IRB) Retail Form to calculate Capital Factor (K), incorporating PD, LGD, R, and Maturity Sensitivity (b).  
  - **Capital Stack Construction**  
    Builds equity and capital components from averaged monthly balances and validated rate assumptions. Capital charges incorporate funding costs, minimum return requirements, and funding benefit adjustments.
  - **Profitability Attribution**  
    Tracks monthly metrics including income, expenses, taxes, funding and capital costs, with consistent application of tax and expense rates.
  - **dbt-Styled Modeling**  
    Modeling layers follow the dbt approach, representing staging, intermediate, and mart layers.  
  - **Color Coding**  
    Color coding is applied consistently across the model and documentation to provide clarity in metrics tracking.

- **Key Metric Adjustments**  
  - Average Monthly Balance, Interest Income, Cost Of Funds
    Normalizes amortization effects to reflect average financials over the loan’s life, impacting downstream metrics.
  - Remaining Maturity (M)
    Uses weighted average remaining term to mitigate maturity sensitivity impacts on capital.
  - Business Indicator (BI)
    Applies Pre-Tax, Pre-Provision (PTPP) as the BI proxy, since their components align directly.
  - Provision  
    Allocates initial Expected Credit Loss (ECL) evenly across the loan term, rather than tracking monthly changes.
  - Funding Benefit Adjustment
    Adjusts MMCOF rates to account for internal transfer pricing inefficiencies.

- **Outputs**  
  - **Personal Credit Portfolio – Model.xlsx**  
    Core modeling workbook assembling validated loan fields, capital stack, profitability metrics, and key performance indicators.  
  - **Personal Credit Portfolio – Model Validation.xlsx**  
    Validates the modeling approach by comparing workbook metrics against the monthly running book, providing governance‑grade assurance of consistency.
  - **Personal Credit Portfolio – Analysis.xlsx**  
    Dashboard‑style summary, with supporting pivot tables, to surface portfolio insights, designed for stakeholder review and commentary overlays.

## Key Insights

- Loan portfolio exhibits strong growth in originations and amounts over the year.
- Pricing is homogeneous across exposure types, yielding differentiated returns that run counter to expected risk‑adjusted behavior.
- Risk-Weighted Asset (RWA) Density clearly demonstrates the impacts of borrower credit quality and collateral types.
- Return On Tangible Common Equity (ROTCE) reveals strong equity returns across secured exposures, with underperformance in unsecured loans even at prime grades.
- Risk-Adjusted Return On Capital (RAROC) highlights capital inefficiency when compared to synthetic hurdle rates.

## Repo Structure

```text
Credit_Portfolio_Modeling/  
├─ README.md                   # Commentary registry and modeling overview  
├── _archived_cloned_repo_/    # Source repo for loan dataset  
├── CostOfFundsCurves/         # Final synthetic curves for funding cost rates  
├── data/
│  ├── raw/                    # Uncleaned source files (portfolio + rate inputs)  
│  └── cleaned/                # Cleaned loan input file  
├── docs/                      # Data dictionary, Metrics Flow Diagrams, etc...
└── excel/                     # Finalized Excel workbooks for mart construction and analysis  
```

## Governance Notes  

- All rates are stored as structured tables and applied consistently  
- All formulas are structured-reference based and validated for numeric equivalence  
- All lookup logic includes fallback handling and unit normalization  
- Remaining Maturity manipulation for K is documented
- Risk Weight Precision Drift in Model Validation:
  - **Observation:** Modeled RW vs time‑series average shows minor drift (≈ −0.0001, −0.0021%).
  - **Cause:** Averaging method floating‑point precision.  
  - **Impact:** Within tolerance band (<0.05%); minimal material effect on capital and profitability metrics.  
  - **Treatment:** Documented; retained for transparency, not adjusted in model.  
- Design Differences Between Model and Validation Workbooks
  - **Observation:** Formula structures differ between the model and validation workbooks.  
  - **Impact:** Outputs demonstrate numeric equivalence and model validity; differences are design‑driven, not logic errors.
  - **Treatment:** Documented; validation workbook serves as a diagnostic tool, not a production artifact.
  
## Learning & Takeaways

- **Governance Hygiene Matters**  
Structured references, deterministic lookup tables, and fallback handling reduce errors and improve transparency.
- **Scalability Requires Modular Design**  
Transitioning from Excel to Snowflake/dbt highlighted the importance of modular transformations and lineage tracking.
- **Risk & Profitability Are Intertwined**  
Linking RWA formation with profitability attribution creates a clean loop that surfaces capital inefficiency.
- **Stakeholder Narration Is Key**  
Dashboards and commentary overlays make technical metrics accessible to non‑technical stakeholders.
- **Synthetic Data Has Limits**  
Homogeneous pricing and lack of delinquency data limit realism, but the framework is extensible to real portfolios.

## Next Steps  

- **Snowflake/dbt Build Out**  
  Transition the validated model from Excel into a Snowflake environment, using dbt for modular transformations, lineage tracking, and governance‑grade reproducibility.

- **Interactive Dashboards**  
  Develop stakeholder‑facing dashboards in Power BI Desktop, Hex Data, and other visualization tools. Focused on drill‑downs by exposure type, credit grade, and capital efficiency overlays.

- **Running Book Integration**  
  Extend the synthetic loan portfolio into a running book with daily feeds from a simulated System of Record (SOR). This enables continuous monitoring, refresh cycles, and scenario testing.

- **Delinquency & Segmentation Analysis**  
  Expand the model to include delinquency rates, customer segmentation, and behavioral overlays. This supports risk diagnostics, pricing differentiation, and portfolio strategy refinement.

## Author  

**Justin Tanous**  
Senior Finance Data Analyst  
Lead architect of modeling logic, responsible for capital attribution, profitability overlays, and governance hygiene.

## Final Thoughts  

This work largely reflects the capital modeling I performed at Wells Fargo. The modeling approach to averaged capital was developed during my tenure. This implementation of that approach is distinct and original to this project. The Average Maturity function represents proprietary modeling logic developed by the author.

Copilot Desktop was used as a thought partner and research assistant on this project, helping provide clarity on the Basel III IRB retail framework and ensuring accuracy in the modeling approach.

## License  

This project is licensed under the MIT License.  
See the LICENSE file for details.
