# Estimating Portugal's Wine Demand Using the Almost Ideal Demand System (AIDS)

**Methods:** Structural Demand Modeling, Almost Ideal Demand System (AIDS), Elasticity Estimation  
**Tools:** R (`micEconAids`, `systemfit`, `tidyverse`)

---

## Project Overview
This project provides an empirical analysis of Portugal’s wine import market, focusing on the competitive dynamics between the world’s three largest producers: **France, Italy, and Spain**. Utilizing an **Almost Ideal Demand System (AIDS)** framework, the study investigates locational preferences and market segmentation in a country that leads the world in per capita wine consumption.

## Research Objectives
* **Market Segmentation:** Determine if wine is treated as a homogeneous product or if locational preferences create distinct market niches.
* **Elasticity Estimation:** Calculate expenditure and price elasticities to classify imports as luxuries or necessities.
* **Substitutability:** Analyze cross-price dynamics (Hicksian and Marshallian) to understand how Portuguese consumers switch between wine origins.

## Econometric Identification
To satisfy microeconomic consistency, I impose the following structural constraints on the system:
* **Homogeneity:** $\sum_{j=1}^n \gamma_{ij} = 0 \ \forall i$ 
* **Symmetry:** $\gamma_{ij} = \gamma_{ji} \ \forall i,j$ 

The model utilizes a **Translog Price Index** to ensure a full AIDS estimation rather than a linear approximation, providing more robust results for policy and market analysis.

## Key Findings
* **France:** Identified as a **necessity/staple** ($\eta_i \approx 0.48$) with highly inelastic demand. Portuguese consumers treat French wine as a consistent part of their consumption basket.
* **Italy & Spain:** Classified as **luxury goods** ($\eta_i > 1$). Spain, in particular, exhibits high price sensitivity, suggesting it captures the "competitive" segment of the market.
* **Economic Growth:** Results suggest that as incomes rise in Portugal, demand for Spanish and Italian wines will grow disproportionately compared to French imports.

---

## 📂 Repository Structure
* **`Portugal_Wine_AIDS_Model.R`**: Primary estimation script. 
    * *Note: This script is configured for **Universal Access**; it pulls the required dataset directly from GitHub, removing the need for local file path configuration.*
* **`Portugal_Wine_Demand_Paper.pdf`**: The complete research paper detailing the theoretical framework, data transformations, and final elasticity results.
* **`Data/portugal_data.csv`**: Cleaned CSV import data (Prices, Quantities, and Budget Shares) sourced from the **FAO of the United Nations (1987-2023)**.

## Reproducibility
Run: **`Portugal_Wine_AIDS_Model.R`**
