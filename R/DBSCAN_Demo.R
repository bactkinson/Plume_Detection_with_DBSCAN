## Code to execute demo

## First, read in the functions required for plume analysis.

# source(paste0(getwd(),"/DBSCAN_Plume_Detection.R"))

## Read in the demo data.

# require(data.table)
# demo_data <- fread(paste0(getwd(),"/Demo_Data.csv"))

## In demo data, there are 9 columns
## providing lat/long coordinates, timestamps,
## and 6 pollutants. Here we are interested in analyzing NOx/CO2/BC/UFP
## (though feel free to leave out/include O3 and PM to experiment!)

## Note: return_dbscan_anomalies will not execute on data files containing 
## lat/long/timestamps. Data must only include pollutants to be analyzed

# dd_to_analyze <- demo_data %>%
#   dplyr::select(BC,CO2,NOx,UFP)

## Run the plume detection on the demo data.
## Set the f_value (see paper) to be 0.03
# dbscan_anomalies <- return_dbscan_anomalies(dd_to_analyze,f_value = 0.03)

## "Execution complete" should print out to the terminal upon completion.
## With our dbscan_anomalies, let's visualize the results.

# dd_to_analyze <- dd_to_analyze %>%
#   cbind(.,"Anomaly"=dbscan_anomalies) %>%
#   dplyr::mutate(Anomaly = as.factor(Anomaly))

## Plot results on 2D scatter plot, color in DBSCAN coded anomalies with red = Anomaly,
## black = Normal

# require(tidyverse)

# ggplot(data=dd_to_analyze,aes(BC,CO2)) +
#   geom_point(aes(color = Anomaly)) +
#   labs(x = bquote("BC (ng/"~m^3~")"),
#        y = bquote(CO[2]~" (ppm)")) +
#   scale_color_manual(values = c("Black","Red"),labels = c("Normal","Anomaly")) + 
#   theme_classic()

## Determine what percentage of data is Normal, Anomaly

# normal_percentage <- length(which(dd_to_analyze$Anomaly==1))/nrow(dd_to_analyze)*100
  
# print(paste0("The number of normal points in this data set is: ", round(normal_percentage,2), "%"))

## Even though it looks small, the black-filled points constitute 71% of the data set!
      