heat_plot <- function(input) {
  
  # filter for extreme heat days by school based on homepage district input and heat tab school input
  heat_filtered <- reactive({
    school_filtered(extreme_heat, input$district, input$school_heat)
  })
  
  renderPlotly({
    
    # Output plot
    heat <- ggplot(data = heat_filtered(),
                   aes(x = year, y = total, fill = scenario)) +
      geom_bar(stat = "identity", position = "dodge") +
      theme_classic() +
      labs(x = "Year",
           y = "Number of Days",
           title = "Number of Extreme Heat Days") +
      theme(legend.position = "top",
            legend.title = element_blank())
    
    plotly::ggplotly(heat) %>%
      layout(legend = list(orientation = "h", y = 1.1,
                           title = list(text = 'Scenarios')),
             margin = list(t = 60),
             barmode = "grouped")
  })
  
}