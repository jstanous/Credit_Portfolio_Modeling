# Credit Portfolio Modeling: dbt on Snowflake

> **Note:** This project phase is a work in progress. Sections will evolve as dbt/Snowflake models are completed.

## Overview

This subproject delivers the previously validated credit portfolio model in a multi-domain dbt project. It uses dbt and Snowflake to surface credit portfolio insights for constituents within banking organizations.

## Objectives

- Leverage validated Credit Portfolio Model to showcase dbt and Snowflake capabilities.
- Build production-grade artifacts for Capital Management, Regulatory Reporting, Sales Enablement, Risk, and Finance Teams.

## Disclaimer  

Aspects of this framework are intended solely for internal profitability modeling and scenario analysis, and do not always reflect or satisfy regulatory reporting requirements.

## Model Overview

- **Model Inputs**  
  - **Source Data**  
    Loan-level records: The full loan portfolio dataset is being used for this phase.  
  - **Lookup Tables**  
    - Cost Of Funds (COF) Rates  
    - Probability of Default (PD)  
    - Collateral/Exposure Types  
    - Loss Given Default (LGD)  
    - Asset Correlation (R)  
    - Rate Assertions

- **Modeling Approach**
  - **Layered Architecture (dbt convention)**  
    Models are organized into staging, intermediate, and mart layers.  
    - *Staging*: Clean and rename raw source data.  
    - *Intermediate*: Apply business logic, enrichments, and joins.  
    - *Mart*: Deliver dimensional and fact tables for downstream analysis.  
  - **Materialization Strategy**  
    All models in this phase are materialized as **tables** to ensure auditability and reproducibility.  
  - **Documentation Blocks (doc-blocks)**  
    Each model includes doc-blocks maintained in the `meta/` directory, propagating documentation into dbt docs and Snowflake objects.  
  - **Multi-Domain Construction**  
    Outputs are designed to serve multiple domains (Capital Management, Regulatory Reporting, Risk, Finance, Sales Enablement) from a unified modeling framework.  

- **Modeling Features**
  - **User-Defined Functions (UDFs)**  
    Snowflake UDFs are wrapped in dbt macros for consistent application across models. Categories include:  
    - LookupFunctions (PD, LGD, COF mappings)  
    - ScalarFunctions (capital factor calculations, maturity adjustments)  
    - StatisticalFunctions (e.g., NORMINV ports)  
    - AmortizingFunctions (loan balance and payment schedules)  
  - **Doc-Block Integration**  
    Model documentation is centralized in `meta/` and linked to dbt artifacts, ensuring transparency for both developers and stakeholders.  
  - **Domain-Specific Outputs**  
    Mart-layer tables surface validated portfolio metrics, capital stack components, and profitability attribution aligned with Basel III IRB retail form.  
  - **Governance and Auditability**  
    Consistent use of table materializations, doc-blocks, and UDF macros ensures regulator-grade traceability and reproducibility.  

- **Assumptions**  
  - All Loan Handling, Rate Assertions, Exclusions, Features, and Key Metric Adjustments remain applicable in this phase.  

- **Outputs**  
  > **WIP:** Mart-layer data products are a work in progress. This section will be updated as necessary.  

## Repo Structure

```text
Credit_Portfolio_Modeling/dbt/
├── README.md                        # This file; overview and repo documentation
├── dbt_project.yml                  # dbt project configuration (name, models, paths, settings)
├── analyses/                        # Ad‑hoc SQL analyses or exploratory queries
├── integrations/                    # Exemplars for integrations and artifacts outside dbt
│  ├── GitHub/                       # GitHub Actions used to publish artifacts to this public repo
│  └── Snowflake/                    # Exemplars for Snowflake objects and integrations
│     ├── Benchmark_NORMINV/         # Case-study of UDF performance
│     └── UserDefinedFunctions/      # Scripts for various Snowflake UDFs
│        ├── AmortizingFunctions/    # UDFs for calculating loan balances and interest payments
│        ├── LookupFunctions/        # UDFs that reference lookup tables (e.g., PD, LGD, CofRate)
│        ├── ScalarFunctions/        # UDFs for scalar calculations (e.g., b, K, RW, R, M)
│        └── StatisticalFunctions/   # Statistical function ports (e.g., NORMINV)
├── macros/                          # Jinja macros wrapping UDFs and reusable SQL logic
├── meta/                            # Model documentation blocks (doc‑blocks for dbt docs site)
│  ├── intermediates/                # doc‑blocks for intermediate models
│  ├── marts/                        # doc‑blocks for dimensional and fact models
│  ├── sources/                      # doc‑blocks for source layer tables
│  └── staging/                      # doc‑blocks for staging models
├── models/                          # dbt model SQL and YAML artifacts
│  ├── intermediates/                # Intermediate transformational models
│  ├── marts/                        # Business‑ready dimensional and fact models
│  ├── sources/                      # Source definitions (YAML configs for raw tables)
│  └── staging/                      # Staging models (cleaned, renamed raw data)
├── seeds/                           # CSV seed files containing reference data
├── snapshots/                       # Snapshot definitions for slowly changing dimensions
└── tests/                           # Custom SQL data tests
```

## Governance Notes  

Governance practices from Excel are being applied to dbt/Snowflake; notes below reflect current implementation status.

- **Rates and Factors as Tables**  
  All rate curves and factors (COF, PD, LGD, R) are stored in Snowflake tables and referenced consistently across dbt models.

- **UDF and Macro Validation**  
  User‑Defined Functions are wrapped in dbt macros. Each macro is unit‑tested for numeric equivalence against benchmark calculations to ensure reproducibility.

- **Lookup Logic**  
  Lookup functions include explicit fallback handling and normalization of units to maintain consistency across domains.

- **Remaining Maturity (M) Handling**  
  Remaining maturity adjustments for capital factor (K) are documented in intermediate models and surfaced in mart‑layer outputs.

- **Precision and Drift**  
  Floating‑point precision differences between Snowflake UDFs and validation scripts are documented. Observed drift is within tolerance bands (<0.05%) and retained for transparency.

- **Design Differences vs. Validation Workbooks**  
  dbt/Snowflake models are structured differently than legacy Excel workbooks. Outputs demonstrate numeric equivalence; differences are design‑driven, not logic errors. Validation workbooks remain diagnostic tools, not production artifacts.

- **Documentation Blocks**  
  All models include doc‑blocks maintained in the `meta/` directory, ensuring governance‑grade documentation is propagated into dbt docs and Snowflake objects.
  
## Learning & Takeaways

> **WIP:** Current notes reflect lessons from the Excel implementation. This section will be updated to highlight dbt/Snowflake-specific practices.

- **Governance Hygiene Matters**  
  Deterministic lookup tables, fallback handling, and doc-block propagation reduce errors and improve transparency.

- **Scalability Requires Modular Design**  
  Transitioning to dbt/Snowflake emphasizes modular transformations, lineage tracking, and table materializations for reproducibility.

- **Risk & Profitability Are Intertwined**  
  Linking RWA formation with profitability attribution remains a guiding principle, now surfaced through mart-layer outputs.

- **Stakeholder Narration Is Key**  
  dbt docs, Snowflake views, and BI dashboards make technical metrics accessible to non-technical stakeholders.

- **Synthetic Data Has Limits**  
  Homogeneous pricing and lack of delinquency data limit realism, but the framework is extensible to real portfolios.

## Author  

**Justin Tanous**  
Senior Data Analyst/Engineer  
Lead architect of modeling logic, responsible for capital attribution, profitability overlays, and governance hygiene.

## License  

This project is licensed under the MIT License.  
See the LICENSE file for details.
