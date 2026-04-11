# The Duality of Risk and Safety in the Bitcoin Market

## 📋 Project Overview
This research investigates whether Bitcoin acts as a **risk-on asset** or a **safe-haven asset** by analyzing its response to distinct macroeconomic shocks. Utilizing a **DCC-GARCH** (Dynamic Conditional Correlation) framework, I test the hypothesis that Bitcoin serves as a quality asset and "Schelling Point" during banking crises, while behaving as a speculative risk-on asset during general market uncertainty (e.g., the Covid-19 pandemic).

### Key Findings
* **COVID-19 (General Crisis):** Bitcoin correlation with the S&P 500 remained positive (~0.40), confirming its role as a risk-on asset.
* **SVB Collapse (Banking Crisis):** Correlation dropped significantly (~0.27), suggesting Bitcoin acts as a **systemic-risk hedge** or "crisis diversifier" when traditional banking stability is questioned.

## 🛠 Technical Stack
* **Econometrics:** DCC-GARCH (Dynamic Conditional Correlation)
* **Data Ingestion:** Python (`yfinance`)

## 📂 Repository Contents
* **`BTC_MacroCrisis.do`**: The Stata replication script. It includes data cleaning, DCC-GARCH estimation, Newey-West robustness checks, and Wald tests for hypothesis testing.
* **`macro_data.csv`**: Daily return data for BTC and the S&P 500 sourced via the `yfinance` API.
* **`The_Duality_of_Risk_and_Safety_in_the_Bitcoin_Market.pdf`**: The full technical paper, including the theoretical framework on focal points and detailed regression tables.

## 🛠 How to Replicate
