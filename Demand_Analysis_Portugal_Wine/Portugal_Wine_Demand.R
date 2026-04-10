library(tidyverse)
library(systemfit)
library(micEconAids)
library(here) 

data <- read_csv(here("Demand_Analysis_Portugal_Wine", "Data", "portugal_wine_data.csv"))

data <- as.data.frame(data)

#Calculate Expenditure
data$Exp = data$p_FR*data$q_FR + data$p_IT*data$q_IT + data$p_SP*data$q_SP + data$p_Other*data$q_Other

#Individual expenditures and shares
data$exFR = data$p_FR*data$q_FR
data$exIT = data$p_IT*data$q_IT
data$exSP = data$p_SP*data$q_SP
data$exOther = data$p_Other*data$q_Other
data$wFR <- data$exFR/data$Exp
data$wIT <- data$exIT/data$Exp
data$wSP <- data$exSP/data$Exp
data$wOther <- data$exOther/data$Exp

summary(data)

#Turn into vectors
p <- c("p_FR", "p_IT", "p_SP", "p_Other")
w <- c("wFR", "wIT", "wSP", "wOther")
Exp <- "Exp"

aids_model <- aidsEst(priceNames = p,
                      shareNames = w,
                      totExpName = Exp,
                      data = data,
                      method = "IL",
                      hom = TRUE,    # Homogeneity
                      sym = TRUE)    # Symmetry
summary(aids_model)

prices <- c(mean(data$p_FR),mean(data$p_IT), mean(data$p_SP), mean(data$p_Other))
shares <- c(mean(data$wFR),mean(data$wIT), mean(data$wSP), mean(data$wOther))

prices
shares

aids_elast <- aidsElas(coef(aids_model), prices = prices, shares = shares, coefCov = vcov(aids_model),
                        df = df.residual(aids_model))
summary(aids_elast)
