# **Loan Portfolio Analysis**

![bank_loan](/src/img/bank_loan.jpg)

## **Introduction**
In 2021, as society began to emerge from the grips of the COVID-19 pandemic, the US economy faced significant challenges. Business activity had slowed, isolation and restrictions had disrupted normal life, and the financial stability of many individuals and businesses was precarious. To combat these issues and stimulate recovery, the US government implemented measures such as lowering interest rates to make loans more affordable and accessible.

The goal of these lower interest rates was to inject much-needed liquidity into the economy, encouraging both individuals and businesses to borrow and spend. This increased spending and investment was intended to help businesses recover and potentially boost employment, which had been negatively impacted by the pandemic's economic slowdown.

## Objectives
The primary objective of this project is to conduct a comprehensive analysis of loan records issued during the critical year of 2021. By delving into this dataset, we aim to gain a deep understanding of how loans performed during this period, characterized by the gradual recovery of the economy from the COVID-19 pandemic and the government's implementation of policies designed to stimulate borrowing and spending.

Our investigation will specifically focus on evaluating the impact of the government's initiative to encourage lower interest rates. We will assess how these reduced rates influenced both the behaviour of borrowers and the ultimate outcomes of the loans themselves. This analysis will provide valuable insights into the effectiveness of this policy in fostering economic recovery, as well as its implications for both lenders and borrowers within the unique financial landscape of the time.

## Data Source
The dataset used for this project offers a comprehensive overview of lending activities across the United States during the pivotal year of 2021. Comprising loan records from various banks nationwide, this dataset provides a unique snapshot of the financial landscape during a period marked by economic recovery and government initiatives to stimulate borrowing.

Each loan record within the dataset contains a wealth of information, encompassing both borrower-specific details and loan-specific attributes. This includes crucial borrower information such as employment status, income verification, and other relevant financial indicators that banks typically consider when assessing loan applications. Additionally, the dataset details the specifics of each loan, including the loan amount, interest rate, current payment status (e.g., current, paid off), and any adverse outcomes such as default or charge-off.

To provide a clearer understanding of the dataset's structure and content, we present a breakdown of the key columns and their respective meanings:

| Column                 | Description                                                                                                                          | Type    | Classification |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------|---------|----------------|
| `id`                   | **Loan ID:** Unique identifier for each loan, serving as a primary key to track and manage loans throughout their lifecycle.         | Integer | Numerical      |
| `address_state`        | **Address State:** Indicates the borrower's location to assess regional risks and compliance with state regulations.                 | String  | Categorical    |
| `application_type`     | **Application Type:** Type of application (Individual or Joint), differentiating the processing and requirements.                    | String  | Categorical    |
| `emp_length`           | **Employee Length:** Provides insights into employment stability, indicating job security and repayment ability.                    | String  | Categorical    |
| `emp_title`            | **Employee Title:** Specifies the borrower's job title, aiding in income source verification and financial capacity assessment.    | String  | Categorical    |
| `grade`                | **Grade:** Risk classification assigned based on creditworthiness, influencing loan pricing and attractiveness to investors.         | String  | Categorical    |
| `home_ownership`       | **Home Ownership:** Indicates housing status, providing insights into financial stability and collateral availability.               | String  | Categorical    |
| `issue_date`           | **Issue Date:** Marks the origination date of the loan, crucial for tracking, interest calculations, and maturity assessments.       | String  | Categorical    |
| `last_credit_pull_date`| **Last Credit Pull Date:** Records when the borrower’s credit report was last accessed, helping monitor creditworthiness updates.   | String  | Categorical    |
| `last_payment_date`    | **Last Payment Date:** Indicates the most recent payment received, tracking payment history and assessing delinquency.              | String  | Categorical    |
| `loan_status`          | **Loan Status:** Shows the current state of the loan (e.g., fully paid, current, default), used for risk analysis and provisioning. | String  | Categorical    |
| `next_payment_date`    | **Next Payment Date:** Estimates the date of the next loan payment, aiding in cash flow forecasting and revenue projection.         | String  | Categorical    |
| `member_id`            | **Member ID:** Unique identifier for the member, used to track individual borrowers across multiple loans.                           | Integer | Numerical      |
| `purpose`              | **Purpose:** Specifies the reason for the loan (e.g., debt consolidation, education), aligning loan terms with borrower needs.       | String  | Categorical    |
| `sub_grade`            | **Sub Grade:** Provides a finer level of risk differentiation within grades, tailoring terms and interest rates to risk profiles.    | String  | Categorical    |
| `term`                 | **Term:** Defines the loan's duration in months, setting the repayment period and structuring loan agreements.                       | String  | Categorical    |
| `verification_status`  | **Verification Status:** Indicates the verification of borrower's financial information, assessing data accuracy and credibility.    | String  | Categorical    |
| `annual_income`        | **Annual Income:** Total yearly earnings of the borrower, used to determine loan eligibility and evaluate creditworthiness.          | Float   | Numerical      |
| `dti`                  | **DTI (Debt-to-Income Ratio):** Measures debt burden relative to income, assessing capacity for additional debt.                     | Float   | Numerical      |
| `installment`          | **Instalment:** Fixed monthly payment amount for the loan, used to structure terms and assess payment affordability.                 | Float   | Numerical      |
| `int_rate`             | **Interest Rate:** Annual cost of borrowing, key in loan pricing, profit management, and investor attraction.                        | Float   | Numerical      |
| `loan_amount`          | **Loan Amount:** Total sum borrowed, defining the principal amount, used to determine the size and scope of the loan.                | Integer | Numerical      |
| `total_acc`            | **Total Accounts:** Total number of credit lines in the borrower's credit file, used for comprehensive credit assessment.            | Integer | Numerical      |
| `total_payment`        | **Total Payment:** Payments received to date for total amount funded, important for financial tracking and analysis.                 | Integer | Numerical      |

## **Results**
This analysis of the 2021 loan dataset has yielded several key insights and actionable recommendations:

1.  **Debt Consolidation as a Primary Driver:** A significant portion of borrowers utilized loans for debt consolidation, suggesting a potential opportunity for financial institutions to develop targeted products and educational resources to address this need.

2.  **Small Business Vulnerability:** Small business loans experienced negative profit margins, highlighting the unique challenges faced by this sector during the post-pandemic recovery and the need for tailored financial support.

3.  **Interest Rate Sensitivity:** A correlation between higher interest rates and increased loan defaults indicates the importance of carefully calibrating interest rate policies to balance risk and reward.

4.  **Regional Disparities:** The analysis revealed distinct regional variations in loan performance, underscoring the need for localized lending strategies and borrower assessments.

5.  **Potential for Optimization:** By addressing the identified issues, the bank can potentially reduce losses from bad loans, maximize profits from good loans, and contribute to a more stable and equitable economic recovery.

These results provide a valuable foundation for refining lending practices, informing policy decisions, and promoting financial well-being for both borrowers and lenders.

## **Executive Summary**

### **Data Preparation**
To prepare our loan data for analysis, we loaded the CSV file into Microsoft SQL Server Management Studio (SSMS). This allowed us to effectively prep the data and run SQL queries. 

The first step involved creating a new database in SSMS to house our loan data. We then imported the CSV file, carefully adjusting column definitions to ensure accurate data transfer. This was crucial for successful query execution within SSMS. 

In summary, importing the loan data CSV into a new SSMS database, with careful column modification, enabled us to streamline data preparation and efficiently perform SQL queries for further analysis.

### **Key Performance Indicators (KPIs) Revealed through SQL Queries**

In this section, we dive into the heart of our loan data analysis by leveraging the power of SQL queries within SSMS. By crafting targeted queries, we unveil a comprehensive set of Key Performance Indicators (KPIs) that illuminate the health and performance of our loan portfolio. These KPIs offer valuable insights into various facets of our loan data, from overall portfolio metrics to the performance of specific loan segments.

**Example KPI 1: Total Number of Loans**

* **SQL Query:**
```sql
SELECT
    COUNT(*) AS Total_Loan_Applications
FROM
    bank_loan_data;
```

* **Image of Results:**

![Total Loan Applications.png](src/img/SQL/KPI/1.%20Total%20Loan%20Applications/Total_Loan_Applications.png)

* **Explanation:** This metric simply represents the total number of loan applications present within the dataset, reflecting the overall volume of lending activity for the bank.

**Example KPI 2: Good Loan Application Percentage**

* **SQL Query:**
```sql
SELECT
    CAST(SUM(IIF(loan_status = 'Fully Paid' OR loan_status = 'Current', 1.0, 0.0))/COUNT(*) * 100 AS DECIMAL(10,3)) AS Good_Loan_App_Pct
FROM
    bank_loan_data;
```

* **Image of Results:**

![image.png](src/img/SQL/KPI/6.%20Good%20Loan%20vs.%20Bad%20Loan%20Performance/Good%20Loan/goodloanpct.png)

* **Explanation:** This metric calculates the percentage of loan applications classified as good loans. 

**Example KPI 3: Loan Status Grid View**

* **SQL Query:**
```sql
SELECT
    loan_status,
    COUNT(*) AS total_loan_app,
    CAST((CAST(COUNT(*)  AS FLOAT)/ CAST(38576 AS FLOAT) * 100) AS DECIMAL(10,3)) AS total_loan_app_pct, 
    SUM(loan_amount) AS total_funded_amt,
    SUM(total_payment) AS total_amt_received,
    CAST(((CAST(SUM(total_payment) AS FLOAT) - CAST(SUM(loan_amount) AS FLOAT)) / CAST(SUM(loan_amount) AS FLOAT) * 100) AS DECIMAL(10,3)) AS loan_profit_ratio,
    SUM(IIF(MONTH(issue_date) = 12, loan_amount, 0)) AS mtd_funded_amt,
    SUM(IIF(MONTH(issue_date) = 12, total_payment, 0)) AS mtd_amt_received,
    ROUND(AVG(int_rate) * 100, 3) AS avg_interest_rate,
    ROUND(AVG(dti), 3) AS avg_dti
FROM
    bank_loan_data
GROUP BY
    loan_status;
```

* **Image of Results:**

![image-2.png](src/img/SQL/KPI/7.%20Loan%20Status%20Grid%20View/grid_view.png)

**Explanation:** This report offers a comprehensive summary of key lending performance indicators, categorized by 'Loan Status.' This structured view allows the bank to quickly assess the health of different segments within its loan portfolio, compare KPIs across loan statuses, and potentially identify areas for risk mitigation or targeted growth opportunities.

**Beyond the Examples: Exploring the Full Range of KPIs**

These examples represent just a glimpse into the 31 KPIs that we have crafted through SQL queries. To delve into the complete analysis and explore the comprehensive analysis notebook.

### **Tableau Dashboard:**  

This interactive dashboard provides a comprehensive view of loan data. It's organized into three main sections, each offering a different level of detail:

1.  **Key Performance Indicators (KPIs):** 
    *   Each section of the dashboard (Summary, Overview, and Details) features a consistent set of KPIs, summarizing crucial metrics like total loan applications, funded amounts, interest rates, and borrower debt-to-income ratios.
    *   Provides monthly averages and changes for quick trend analysis. 

![KPI.png](src/img/Dashboard/KPI.png)

1.  **Summary:**
    *   Breaks down loan performance into "good" (paid off or current) and "bad" (charged off or defaulted) categories.
    *   Presents a detailed table of loan statuses (e.g., current, fully paid, charged off).

![Summary.png](src/img/Dashboard/Summary.png)

3.  **Overview:**
    *   Visualizes monthly trends in loan applications, funding, and repayment amounts.
    *   Allows comparison of loan metrics by state, employment length, loan purpose, and homeownership status.
    *   Includes interactive filters to customize the view.

![Overview.png](src/img/Dashboard/Overview.png)

4.  **Details:**
    *   Displays a comprehensive table of individual loan records.
    *   Offers filtering and sorting options for in-depth analysis.

![Details.png](src/img/Dashboard/Details.png)

**Key Takeaways:**

*   The dashboard allows for both high-level overviews and granular analysis.
*   Users can easily compare loan metrics across different dimensions (time, location, borrower characteristics).
*   Interactive elements like filters empower users to explore the data in ways most relevant to their interests.

## **Access the Analysis**

* **Interactive Dashboard:** Explore the data visually and interactively through our Tableau dashboard **[here](https://public.tableau.com/views/BankLoanReportDashboard_17165926472590/Summary?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)**.

* **Jupyter Notebook:** Dive deeper into the analysis code and methodology used to generate the insights presented in the dashboard **[here](/notebooks/Data_Preparation_and_Analysis.ipynb)**.

## Conclusion
This project provided valuable insights into the lending landscape during the critical recovery period of 2021 following the COVID-19 pandemic. Analyzing loan data revealed intriguing patterns, such as the disproportionate struggles faced by small businesses in repaying loans, highlighting the economic challenges of that time.  

A deeper dive into loan performance showed a correlation between higher interest rates and loan defaults, raising questions about the sustainability of lending practices during uncertain economic times. Additionally, while many loans remained current, their higher-than-average interest rates suggested potential future risks for both borrowers and lenders.

The analysis also unveiled interesting variations across states, indicating diverse economic climates and lending practices throughout the country.  

Through this project, I honed my querying skills, effectively extracting relevant information from a complex dataset. This, combined with data analysis and visualization techniques, culminated in the creation of an accessible Tableau dashboard. This user-friendly tool empowers others to effortlessly explore and understand the complexities of the 2021 loan landscape.

Overall, this project was a rewarding experience, reinforcing the power of data analysis in illuminating real-world economic trends and challenges.
