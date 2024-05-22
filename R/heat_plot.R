heat_plot <- function(input, output) {
  
  # filter for extreme heat days by school based on homepage district input and heat tab school input
  heat_filtered <- reactive({
    school_filtered(extreme_heat, input$district, input$school_heat)
  })
  
  renderPlotly({
    # Output plot
    heat_bar <- ggplot(data = heat_filtered(),
                   aes(x = year, y = total, fill = scenario)) +
      geom_bar(stat = "identity", position = "dodge") +
      theme_classic() +
      labs(x = "Year",
           y = "Number of Days",
           title = "Number of Extreme Heat Days") +
      theme(legend.position = "top",
            legend.title = element_blank()) +
      scale_x_continuous(breaks = seq(2005, 2064, by = 5)) +
      scale_fill_manual(values = c("High greenhouse gas emissions"= "#ff0000", 
                                   "Reduced greenhouse gas emissions"= "#ffc100"))
    
    heat_bar_plt <- plotly::ggplotly(heat_bar) %>% 
      layout(legend = list(orientation = "h", y = 1.1,
                           title = list(text = 'Scenarios')),
             margin = list(t = 60),
             barmode = "grouped")
      
      })
    
  
}