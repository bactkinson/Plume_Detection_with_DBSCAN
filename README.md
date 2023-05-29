# Plume_Detection_with_DBSCAN

This repository contains a demo of code used to detect plumes in mobile air quality monitoring time series.

### Overview
To address plume detection in time series, we recast the problem as an anomaly detection problem and visualize plumes as anomalies scattered outwards from an n-dimensional origin. A graphical example of this concept is provided here:

![DBSCAN_Example](/Misc/DBSCAN_Illustration.png)

One could constrict their analysis to these identified anomalies to understand source impacts on generated mobile measurements.

### Basic Usage
To illustrate the basic use of this algorithm, we will walk through DBSCAN_Demo.R.

Functions used to implement the basic algorithm are sourced from DBSCAN_Plume_Detection.R. This is done in the first line.

`source(paste0(getwd(),"/DBSCAN_Plume_Detection.R"))`

Next, we load in the dataset and select BC, CO2, NOx, and UFP for analysis.

`demo_data <- fread(paste0(getwd(),"/Demo_Data.csv"))`

`dd_to_analyze <- demo_data %>%
  dplyr::select(BC,CO2,NOx,UFP)`

Plume detection is implemented by the function `return_dbscan_anomalies`.

`dbscan_anomalies <- return_dbscan_anomalies(dd_to_analyze,f_value = 0.03)`

The output of `return_dbscan_anomalies` is a vector with flag = 1 representing a "normal" measurement and flag = 2 representing an "anomaly." In the illustration above, 1 captures all the black colored points, while 2 captures all the red colored points.

`f_value` is a parameter used to tune DBSCAN algorithm implementation. It's a scalar that is multiplied by the total number of points in the dataset to yield a parameter used in DBSCAN implementation. Feel free to explore different f_values in your work.

Once we determine all DBSCAN labeled anomalies, we can analyze their distributions like below.

`dd_to_analyze <- dd_to_analyze %>%
  cbind(.,"Anomaly"=dbscan_anomalies) %>%
  dplyr::mutate(Anomaly = as.factor(Anomaly))`

`require(tidyverse)`

`ggplot(data=dd_to_analyze,aes(BC,CO2)) +
  geom_point(aes(color = Anomaly)) +
  labs(x = bquote("BC (ng/"~m^3~")"),
       y = bquote(CO[2]~" (ppm)")) +
  scale_color_manual(values = c("Black","Red"),labels = c("Normal","Anomaly")) + 
  theme_classic()`

![DBSCAN_Example](/Misc/DBSCAN_Illustration.png)

We produce the same scatterplot above.

One could also extract these anomalies for further analysis (e.g., k-means, PCA, etc.).

If you have any issues in implementing this method or have suggestions for improvement, I'd love to hear about it. Please raise it as an issue ticket in the repository. Alternatively, email blakeactkinson@gmail.com.

This work was created by Blake Actkinson with input from Robert Griffin at Rice University.



