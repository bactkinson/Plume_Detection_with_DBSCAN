## Required packages to run functions below.
require(dbscan)
require(tidyverse)

## Required functions
find_the_knee <- function(poll_data,min_pts){
  
  tt <- sort(dbscan::kNNdist(poll_data,k=min_pts))

  dist_subset <- tt[1:30]
  for(i in 31:length(tt)){
    if(tt[i] > (mean(dist_subset) + 3*sd(dist_subset))){
      return(tt[i])
      break
    } else{
      dist_subset <- c(dist_subset,tt[i])
    }
  }
  return(tt[length(tt)])
}

return_dbscan_anomalies <- function(data,f_value){
  
  scaled_data <- data %>%
      dplyr::mutate_all(scale)
  
  min_pts_param <- f_value*nrow(scaled_data)
  
  current_eps <- find_the_knee(scaled_data,min_pts = min_pts_param)
  
  db_clust <- dbscan::dbscan(scaled_data,minPts = min_pts_param,eps = current_eps,borderPoints = FALSE)
  
  assignments <- db_clust$cluster
  
  assignments[assignments==0] <- 2
  
  print("Execution complete")
  
  return(assignments)
}


