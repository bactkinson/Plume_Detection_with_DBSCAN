# Plume_Detection_with_DBSCAN

This repository contains code for the DBSCAN Plume Detection Tool R Shiny app.

**The app can be accessed at the following URL:** https://bactkinson.shinyapps.io/plume_detection_with_dbscan/

### Overview
To address plume detection in time series, we recast the problem as an anomaly detection problem and visualize plumes as anomalies scattered outwards from an n-dimensional origin. A graphical example of this concept is below:

![App_Post_Analysis_Example](/Misc/App_Post_Analysis_Example.png)

One could constrict their analysis to these identified anomalies to understand source impacts on collected mobile air pollution measurements.

We have packaged this method into an R Shiny app deployed through shinyapps.io. The remainder of this README will walk you through how to use the app. If desired, you could also clone the app from this repository and run it locally.

### DBSCAN Plume Detection Tool: Basic Usage
In this walkthrough, we will upload a file called "Demo_Data.csv". The file is located within the data folder in this repository. The app is currently written to only accept .csv or .tsv file formats with the name of the variable stored in the first row of the file. Here's a snapshot of DemoData.csv:

![File_Example](/Misc/File_Example.png)

Functions used to implement the basic algorithm are sourced from DBSCAN_Plume_Detection.R. 

When you first open the app, you will be greeted with the following interface:

![App_Start_Example](/Misc/App_Start_Example.png)

Click the "Browse..." button underneath the "Upload Data File" tab to load data into the app. You have the option of either uploading the default dataset that comes with this app's distribution located in the data folder and called "Demo_Data.csv" or uploading a file of your own. **Please note that uploading a file is required to use the app.** The app will not run otherwise.

After loading in the data, checkbox and dropdown lists on the app will be filled. With Demo_Data.csv, the app would look like the following:

![App_Before_Analysis_Example](/Misc/App_Before_Analysis_Example.png)

Before proceeding with the analysis, we need to do the following:

1. Select an f value for the MinPts estimate.
2. Select the variables to be analyzed.

`f_value` is a parameter used to tune DBSCAN algorithm implementation. It's a scalar that is multiplied by the total number of points in the dataset to yield a parameter used in DBSCAN implementation and is required to run the method. Feel free to explore different f_values in your work. To select an f_value, type a value into the "f value for MinPts estimate" box, and increment the value by 0.01 using the arrows that appear on the right side of the box.

Select the variables to be analyzed by checking the box corresponding to each variable name under "Select the variables to be analzyed."

In this walkthrough, we've decided to use an f_value of 0.03 and analyze our BC, CO2, UFP, and NOx measurements for plumes. After putting 0.03 in the MinPts estimate box and checking the boxes next to BC, CO2, UFP, and NOx, we click the "ANALYZE" button to proceed with the plume detection. A notification will popup in the bottom right hand corner of your screen to let you know that the data are currently being analyzed:

![Analyzing_Data_Note](/Misc/Analyzing_Data_Note.png)

Once analysis is complete, a 2D scatterplot and table will populate the right hand portion of the screen:

![App_Post_Analysis_Example](/Misc/App_Post_Analysis_Example.png)

The scatterplot depicts labeled plume anomalies in red and non-plume anomalies in black. The table consists of your data variable with table headings corresponding to the variable names in the input data file, as well as the label for each point ("1" is non-plume, "2" is plume) and the color of each point in the scatterplot.

To control which data are displayed on the scatterplot, use the drop down menus labeled "Choose variable to be plotted on x-axis" and "Choose variable to be plotted on y-axis." Variable names in the dropdown menu correspond to the variable names in the input data file.

To save the scatterplot image, click the "Save plot to .png" button. To save the labeled data, click the "Save output to .csv" button.

**Important Note:** For large datasets (>15000 data points), it's recommended to clone the app from this repository and run it locally. The app is likely to run into shinyapps.io memory constraints with larger datasets (the app will not run and instead timeout  upon hitting the ANALYZE button).

If you have any issues in implementing this method or have suggestions for improvement, I'd love to hear about it. Please raise it as an issue ticket in the repository. Alternatively, email blakeactkinson@gmail.com.

This work was created by Blake Actkinson with input from Robert Griffin at Rice University.



