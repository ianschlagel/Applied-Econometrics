# The Duality of Risk and Safety in the Bitcoin Market

## 📋 Project Overview
This research investigates whether Bitcoin acts as a **risk-on asset** or a **safe-haven asset** by analyzing its response to distinct macroeconomic shocks. Utilizing a **DCC-GARCH** (Dynamic Conditional Correlation) framework, I test the hypothesis that Bitcoin serves as a quality asset and "Schelling Point" during banking crises, while behaving as a speculative risk-on asset during general market uncertainty (e.g., the Covid-19 pandemic).

### Key Findings
* **COVID-19 (General Crisis):** Bitcoin correlation with the S&P 500 remained positive (~0.40), confirming its role as a risk-on asset.
* **SVB Collapse (Banking Crisis):** Correlation dropped significantly (~0.27), suggesting Bitcoin acts as a **systemic-risk hedge** or "crisis diversifier" when traditional banking stability is questioned.

## 🛠 Technical Stack
* **Econometrics:** DCC-GARCH (Dynamic Conditional Correlation)
* **Data Ingestion:** Python (`yfinance`)

## 📂 Repository Structure
* **`DCC_GARCH_Estimation.R`**: Main script for GARCH modeling and correlation testing.
* **`Data_Ingestion.py`**: Python script used to fetch daily BTC and GSPC returns from Yahoo! Finance.
* **`Bitcoin_Risk_Duality_Paper.pdf`**: The full working paper containing the theoretical framework and result tables.
* **`Data/`**: Contains the raw and processed time-series data.
* **`Figures/`**: Dynamic correlation plots for the 2020 and 2023 crisis windows.

## 🚀 How to Run
1. **Data Collection**:
   If you wish to refresh the data, run the Python script (requires `yfinance`):
   ```bash
   pip install yfinance
   python Data_Ingestion.py
