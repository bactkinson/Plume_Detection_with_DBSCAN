## Server for the DBSCAN plume Shiny app

server <- function(input,output){
  
  ## If the object for file input is null
  ## Run the DBSCAN anomaly detection on dd
  dd <- reactive({
    req(input$upload)
    
    ext <- tools::file_ext(input$upload$name)
    switch(ext,
      csv = vroom::vroom(input$upload$datapath, delim = ","),
      tsv = vroom::vroom(input$upload$datapath, delim = "\t"),
      validate("Invalid file; Please upload a .csv or .tsv file")
    )
  })
 
  observeEvent(dd(), {
    choices <- names(dd())
    updateCheckboxGroupInput(inputId = "analytes", choices = choices)
    updateSelectInput(inputId = "x_value", choices = choices)
    updateSelectInput(inputId = "y_value", choices = choices)
    
  })
  

  ## Click the action button and perform the DBSCAN analysis on the select subset
  ## of analytes
  observeEvent(input$analyze, {
       
    validate(need(input$upload,"Need to upload data!"))

    validate(need(input$analytes,"Need to select analytes for analysis!"))
    
    dd_subset <- dd()[colnames(dd()) %in% input$analytes]
    
    ## Find the knee given the user's f_val input
    dd_anoms <- return_dbscan_anomalies(dd_subset, input$f_val)
    
    print("Analysis Complete")
    
    ## Update dd() with the anomaly output
    final_output_data <- dd()
    
    final_output_data <- cbind(final_output_data,"Anomaly"=dd_anoms) %>%
      mutate(pt_color = dplyr::case_when(Anomaly == 1 ~ "black",
                                         Anomaly == 2 ~ "red"))
    
    output$test <- renderTable(head(final_output_data))    
    
    output$ts_plot <- renderPlot({
      ggplot(data = final_output_data,aes_string(x = input$x_value, y = input$y_value))+
        geom_point(color = final_output_data$pt_color) + 
        theme_classic()
    })
    
    output$results  <- downloadHandler(
      filename = function() {
        paste0("DBSCAN_Tool_Results.csv")
      },
      content = function(filename) {
        write.csv(final_output_data, filename)
      }
    )
    
    output$output_plot  <- downloadHandler(
      filename = function() {
        paste0("DBSCAN_Tool_Results.png")
      },
      content = function(filename) {
        ggsave(filename)
      }
    )
    
    
  })
  
  
  
  
}