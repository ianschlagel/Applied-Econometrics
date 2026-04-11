"""
Data Extraction Script for Bitcoin DCC-GARCH Project
Author: Ian Schlagel
Description: Downloads daily closing prices for Bitcoin and the S&P 500 
             from Yahoo Finance for use in Stata analysis.
"""

import yfinance as yf
from google.colab import files # Remove this line if not using Colab

# 1. Define Tickers (Bitcoin & S&P 500)
tickers = ["BTC-USD", "^GSPC"]

# 2. Set Date Range
start_date = "2020-01-01"
end_date = "2025-11-10"

# 3. Download Data
print(f"Downloading data for {tickers}...")
data = yf.download(tickers, start=start_date, end=end_date)['Close']

# 4. Save to CSV
output_file = "macro_data.csv"
data.to_csv(output_file)
print(f"Success! {output_file} created.")
