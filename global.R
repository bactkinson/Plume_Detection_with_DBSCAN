## R Shiny App for detecting plumes with DBSCAN
## Created by Blake Actkinson

## Load packages
library(data.table)
library(tidyverse)
library(dbscan)

library(shiny)

# default_data <- fread("data/Demo_Data.csv")
source("R/DBSCAN_Plume_Detection.R")

# dd_subset <- dd %>%
#     dplyr::select(BC,CO2,NOx,UFP)
# 
# db_output <- return_dbscan_anomalies(dd_subset,f_value = 0.03)
# 
# dd_subset <- dd_subset %>%
#   cbind(.,"Anomaly"=db_output,"Time"=dd$LST) %>%
#   dplyr::mutate(Anomaly = as.factor(Anomaly))


## To do:
## Rewrite GitHub repo to walk users through the app

