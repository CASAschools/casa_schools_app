extreme_precip_plot <- function(input,output) {
  
  # filter data based on school
  precip_filtered <- reactive({
    school_filtered(names_precip_merge, input$district, input$school_precip)
  })
  
  renderPlotly({
    # # Filter data based on school
    # filtered_data <- subset(names_precip_merge, SchoolName == input$school_precip)
    
    # output plot
    precip <- ggplot(data = precip_filtered(),
                     aes(x = year, y = total, fill = scenario)) +
      geom_bar(stat = "identity", position = "dodge") +
      theme_classic() +
      labs(x = "Year",
           y = "Number of Extreme Precipitation Days") +
      theme(legend.position = "top",
            legend.title = element_blank())
    
    # output plot 
    plotly::ggplotly(precip) %>%
      layout(legend = list(orientation = "h", y = 1.1, title = list(text = 'Scenarios')),
             margin = list(t = 60),
             barmode = "grouped")
  })
}
