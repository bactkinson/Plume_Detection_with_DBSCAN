## UI for the DBSCAN Plume Shiny App

ui <- fluidPage(
  titlePanel("DBSCAN Plume Detection Tool"),
  ## Upload file button
  sidebarLayout(
    sidebarPanel(
      
      fileInput("upload", NULL),
      
      ## Choose epsilon value
      numericInput("f_val","f value for MinPts estimate", value = 0.01, step = 0.01),
      
      ## Select columns to analyze
      checkboxGroupInput("analytes","Select the variables to be analyzed",
                   choices = c("NULL"),
                   select = NULL),
      
      ## Analyze action button
      actionButton("analyze", "ANALYZE"),
      
      ## Select variable for x axis
      selectInput("x_value", "Choose variable to be plotted on x-axis",
                  choices = NULL,
                  selected = NULL),
      
      ## Select variable for y axis
      selectInput("y_value", "Choose variable to be plotted on y-axis",
                  choices = NULL,
                  selected = NULL),
      
      ## Save results button
      downloadButton("results","Save output to .csv"),
      
      ## Save plot button
      downloadButton("output_plot", "Save plot to .png")
    ),
    
    mainPanel(
      
      ## Time series graphic
      plotOutput("ts_plot"),
      
      tableOutput("test")
    )
  )
)