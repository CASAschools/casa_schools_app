extreme_precipitation_plot <- function(inputId){
  
  # Develop plot 
  heat <- ggplot(data = extreme_precip1,
                 aes(x = year, y = total, fill = scenario)) +
    geom_bar(stat = "identity", position = "dodge") +
    theme_classic() +
    labs(x = "Year",
         y = "Number of Days",
         title = "Number of Extreme Precipitation Days") +
    theme(legend.position = "top",
          legend.title = element_blank())
  
  renderPlotly({
    
    plotly::ggplotly(heat) %>%
      layout(legend = list(orientation = "h", y = 1.1,
                           title = list(text = 'Scenarios')),
             margin = list( t = 60),
             barmode = "grouped")
    
    
    
    
  })
  
}