# Synthetic USD Cost of Funds Curves – 2021

Cost of Funds (COF) rates represent the effective interest rate a bank pays to borrow money, serving as the baseline for pricing loans and evaluating profitability across products and tenors. This artifact reconstructs synthetic 3Y and 5Y LIBOR-based USD COF curves using public market rates and bank‑specific funding overlays.

## Source Inputs

| Curve Name | Source | Description |  
|------------|--------|-------------|
| DTB3       | U.S. Treasury Par Yield (3M) | Proxy for short-term risk-free rate |
| TEDRATE    | 3M Treasury/LIBOR Spread     | Proxy for bank credit risk          |
| ParYield3Y | U.S. Treasury Par Yield (3Y) | Market-implied 3Y term premium      |
| ParYield5Y | U.S. Treasury Par Yield (5Y) | Market-implied 5Y term premium      |

Missing values were infilled using prior market data when available, backfilled otherwise.  
Rates are stored as decimals (e.g., 0.0025 = 0.25%). Multiply by 100 for percentage display.

## Bank Funding Risk Premium Overlay

| Term          | Premium |
|---------------|---------|
| RiskOverlay3Y | 25 bps  |
| RiskOverlay5Y | 40 bps  |

Reflects 2021 liquidity posture and longer-term funding optionality for large regional and national banks.

## Synthetic LIBOR and COF Rate Construction

| Curve Name    | Formula                  | Description                        |  
|---------------|--------------------------|------------------------------------|
| LIBOR_3M      | DTB3 + TEDRATE           | Synthetic short‑term funding rate. |
| TermPremium3Y | ParYield3Y - DBT3        | 3-year Treasury slope adjustment.  |
| TermPremium5Y | ParYield5Y - DBT3        | 5-year Treasury slope adjustment.  |
| LIBOR_3Y      | LIBOR_3M + TermPremium3Y | Synthetic 3-year funding rate.     |
| LIBOR_5Y      | LIBOR_3M + TermPremium5Y | Synthetic 5-year funding rate.     |
| USD_COF_3Y    | LIBOR_3Y + RiskOverlay3Y | Final 3-year COF curve.            |
| USD_COF_5Y    | LIBOR_5Y + RiskOverlay5Y | Final 5-year COF curve.            |

Simulates LIBOR term extensions using Treasury slope logic. Final COF curves represent go-to-market funding costs under 2021 conditions.

## File Structure

```text
Credit_Portfolio_Modeling/
└── data/
   ├── raw/
   │  ├── FRED_DTB3_Y2021.xlsx
   │  ├── FRED_TEDRATE_Y2021.xlsx
   │  └── USTreasury_TBills_ParYieldCurveRates-Y2021.xlsx
   └── rates/
      └── CostOfFundsCurves_Synthetic_Y2021.xlsx
```

## Source Data

[FRED DBT3](https://fred.stlouisfed.org/series/DTB3)  
[FRED TEDRATE](https://fred.stlouisfed.org/series/TEDRATE)  
[US Treasury Rates](https://home.treasury.gov/resource-center/data-chart-center/interest-rates/daily-treasury-rate-archives)  

All inputs are public and non-sensitive.
