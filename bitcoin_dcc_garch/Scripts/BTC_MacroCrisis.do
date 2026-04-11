
* ============================================================
* TITLE: The Duality of Risk and Safety in the Bitcoin Market
* AUTHOR: Ian Schlagel
* ============================================================

import delimited "https://github.com/ianschlagel/Applied-Econometrics/raw/main/bitcoin_dcc_garch/Data/macro_data.csv", clear

* --- Rename variables back to specific capitalization ---
rename date Date
rename btc BTC
rename gspc GSPC

* == Set up == *
* --- 1. Keep only common trading days ---

drop if GSPC == .

* --- 2. Create the gap-free timeline ---
gen trading_day = _n
tsset trading_day

* --- 3. Create returns ---
gen r_btc = (ln(BTC) - ln(L.BTC)) * 100
gen r_gspc = (ln(GSPC) - ln(L.GSPC)) * 100

* --- 4. Drop the one missing row ---
drop if r_btc == .

* == model == *	
	
* --- Step 1: Run the DCC model ---
* (This runs the model and fills the e() memory)
mgarch dcc (r_btc r_gspc = ), arch(1) garch(1) difficult

* --- Step 2: Predict the Variance-Covariance Matrix ---
* It will create 3 new variables:
* H_11 = Variance(r_btc)
* H_12 = Covariance(r_btc, r_gspc)
* H_22 = Variance(r_gspc)
predict H_11 H_12 H_22, variance

* --- Step 3: Calculate the Correlation ---
* The correlation (Rho) is: Cov(1,2) / (sqrt(Var(1)) * sqrt(Var(2)))
gen dcc_btc_gspc = H_12 / (sqrt(H_11) * sqrt(H_22))
label var dcc_btc_gspc "DCC (BTC-GSPC)"

* --- Step 4: Plot your final result ---
	
*Full Period
	tsline dcc_btc_gspc if trading_day >= 0 & trading_day <= 1472, ///
    title("Dynamic Conditional Correlation (BTC vs. S&P 500)") ///
    subtitle("March 2023 - April 2025 (Selected Window)") ///
    ytitle("Correlation (Rho)") ///
    legend(off) ///
	xline(51, lpattern(dot) lcolor(black)) ///
	xline(803, lpattern(dot) lcolor(black)) ///
	
*During March 16, 2020 treatment (Day 51)
	tsline dcc_btc_gspc if trading_day >= 1 & trading_day <= 100, ///
    title("Dynamic Conditional Correlation (BTC vs. S&P 500)") ///
    ytitle("Correlation (Rho)") ///
    legend(off) ///
xline(51, lpattern(dot) lcolor(black) lwidth(thick))

*During March 10, 2023 treatment (Day 803)
	tsline dcc_btc_gspc if trading_day >= 753 & trading_day <= 852, ///
    title("Dynamic Conditional Correlation (BTC vs. S&P 500)") ///
    ytitle("Correlation (Rho)") ///
    legend(off) ///
xline(803, lpattern(dot) lcolor(black) lwidth(thick))


* --- Step 5: Final outputs ---

*==========30-day window==========*

* Create the dummy variable 'crisis_window'
capture drop crisis_window
gen crisis_window = 0
replace crisis_window = 1 if trading_day >= 803 & trading_day <= 832
* Create the dummy variable 'crisis_window2'
capture drop crisis_window2
gen crisis_window2 = 0
replace crisis_window2 = 1 if trading_day >= 51 & trading_day <= 80
*Together
reg dcc_btc_gspc i.crisis_window i.crisis_window2


*==== Newey-West for Robustness==== (makes s.e.'s smaller??) ====*

newey dcc_btc_gspc i.crisis_window i.crisis_window2, lag(5)
* == Hypo Testing == *
test _cons + 1.crisis_window = _cons + 1.crisis_window2

test _cons + 1.crisis_window = 0


*==========50-day window==========*

* Create the dummy variable 'crisis_window'
capture drop crisis_window
gen crisis_window = 0
replace crisis_window = 1 if trading_day >= 803 & trading_day <= 852
* Create the dummy variable 'crisis_window2'
capture drop crisis_window2
gen crisis_window2 = 0
replace crisis_window2 = 1 if trading_day >= 51 & trading_day <= 100
*Together
reg dcc_btc_gspc i.crisis_window i.crisis_window2

*==== Newey-West for Robustness==== (makes s.e.'s smaller??) ====*

newey dcc_btc_gspc i.crisis_window i.crisis_window2, lag(5)

* == Hypo Testing == *
test _cons + 1.crisis_window = _cons + 1.crisis_window2

test _cons + 1.crisis_window = 0

*==========100-day window==========*

* Create the dummy variable 'crisis_window'
capture drop crisis_window
gen crisis_window = 0
replace crisis_window = 1 if trading_day >= 803 & trading_day <= 902
* Create the dummy variable 'crisis_window2'
capture drop crisis_window2
gen crisis_window2 = 0
replace crisis_window2 = 1 if trading_day >= 51 & trading_day <= 150
*Together
reg dcc_btc_gspc i.crisis_window i.crisis_window2

*==== Newey-West for Robustness==== (makes s.e.'s smaller??) ====*

newey dcc_btc_gspc i.crisis_window i.crisis_window2, lag(5)

* == Hypo Testing == *
test _cons + 1.crisis_window = _cons + 1.crisis_window2

test _cons + 1.crisis_window = 0

*==========200-day window==========*

* Create the dummy variable 'crisis_window'
capture drop crisis_window
gen crisis_window = 0
replace crisis_window = 1 if trading_day >= 803 & trading_day <= 1002
* Create the dummy variable 'crisis_window2'
capture drop crisis_window2
gen crisis_window2 = 0
replace crisis_window2 = 1 if trading_day >= 51 & trading_day <= 250
*Together
reg dcc_btc_gspc i.crisis_window i.crisis_window2

*==== Newey-West for Robustness==== (makes s.e.'s smaller??) ====*

newey dcc_btc_gspc i.crisis_window i.crisis_window2, lag(5)

* == Hypo Testing == *
test _cons + 1.crisis_window = _cons + 1.crisis_window2

test _cons + 1.crisis_window = 0




* --- appendix: Plot BTC and GSPC Prices ---

* --- Plot BTC vs. GSPC over Full Period ---

* 1. Define the plot parameters
local start_day = 0
local end_day = 1472      
local tick_increment = 250 // Increased increment to reduce clutter

* 2. Plot BTC vs GSPC with adjusted legend position
twoway (line BTC trading_day, yaxis(1) lcolor(blue) lpattern(solid)) ///
       (line GSPC trading_day, yaxis(2) lcolor(red) lpattern(dash)), ///
       title("BTC vs. S&P 500 Price Performance (01/01/2020 - 11/07/25)") ///
       subtitle("Dual Y-Axes for Price Levels") ///
       ytitle("BTC Price (Y1)", axis(1)) ///
       ytitle("S&P 500 Price (Y2)", axis(2)) ///
       legend(label(1 "Bitcoin (BTC)") label(2 "S&P 500 (GSPC)") position(6) row(1)) ///
       tlabel(`start_day'(`tick_increment')`end_day')

	   
*===== Crisis 1 =====*
* 1. Define the start and end points for your plot
local start_day = 753
local end_day = 852
local crisis_line = 803

* 2. Plot BTC and GSPC Prices using dual axes
twoway (line BTC trading_day if trading_day >= `start_day' & trading_day <= `end_day', yaxis(1) lcolor(blue) lpattern(solid)) ///
       (line GSPC trading_day if trading_day >= `start_day' & trading_day <= `end_day', yaxis(2) lcolor(red) lpattern(dash)), ///
       title("BTC vs. S&P 500 Price Performance") ///
       subtitle("Around March 10, 2023 Banking Crisis") ///
       ytitle("BTC Price (Y1)", axis(1)) ///
       ytitle("S&P 500 Price (Y2)", axis(2)) ///
       legend(label(1 "Bitcoin (BTC)") label(2 "S&P 500 (GSPC)")) ///
       xline(`crisis_line', lpattern(dot) lcolor(black)) ///
       tlabel(`start_day'(25)`end_day') 

*===== Crisis 2 =====*
* 1. Define the start and end points for your plot
local start_day = 2
local end_day = 100
local crisis_line = 51

* 2. Plot BTC and GSPC Prices using dual axes
twoway (line BTC trading_day if trading_day >= `start_day' & trading_day <= `end_day', yaxis(1) lcolor(blue) lpattern(solid)) ///
       (line GSPC trading_day if trading_day >= `start_day' & trading_day <= `end_day', yaxis(2) lcolor(red) lpattern(dash)), ///
       title("BTC vs. S&P 500 Price Performance") ///
       subtitle("Around March 16, 2020 Covid-19 Crisis") ///
       ytitle("BTC Price (Y1)", axis(1)) ///
       ytitle("S&P 500 Price (Y2)", axis(2)) ///
       legend(label(1 "Bitcoin (BTC)") label(2 "S&P 500 (GSPC)")) ///
       xline(`crisis_line', lpattern(dot) lcolor(black)) ///
       tlabel(`start_day'(25)`end_day') 


