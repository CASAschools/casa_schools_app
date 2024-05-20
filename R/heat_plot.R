heat_plot <- function(input, output) {
  
  # filter for extreme heat days by school based on homepage district input and heat tab school input
  heat_filtered <- reactive({
    school_filtered(extreme_heat, input$district, input$school_heat)
  })
  
  renderPlotly({
    if(input$change_plot[[1]] %in% "Bar plot"){
    # Output plot
    bar_graph <- ggplot(data = heat_filtered(),
                   aes(x = year, y = total, fill = scenario)) +
      geom_bar(stat = "identity", position = "dodge") +
      theme_classic() +
      labs(x = "Year",
           y = "Number of Days",
           title = "Number of Extreme Heat Days") +
      theme(legend.position = "top",
            legend.title = element_blank()) +
      scale_fill_manual(values = c("High greenhouse gas emissions"= "#ff0000", 
                                   "Reduced greenhouse gas emissions"= "#ffc100"))
    
    bar_graph_plt <- plotly::ggplotly(bar_graph) %>% 
      layout(legend = list(orientation = "h", y = 1.1,
                           title = list(text = 'Scenarios')),
             margin = list(t = 60),
             barmode = "grouped")
    
    
    }
    else if(input$change_plot[[1]] %in% "Line graph") {
      
      line_graph <- ggplot(data = heat_filtered(),
                           aes(x = year, y = total, color = scenario)) +
        geom_smooth(method = "lm", se = FALSE) +
        theme_classic() +
        labs(x = "Year",
             y = "Number of Days",
             title = "Trend of Extreme Heat Days") +
        theme(legend.position = "top",
              legend.title = element_blank()) +
        scale_color_manual(values = c("High greenhouse gas emissions"= "#ff0000", 
                                      "Reduced greenhouse gas emissions"= "#ffc100"))
    
      line_graph_plt <- plotly::ggplotly(line_graph) %>% 
        style(hoverinfo = 'none') %>% 
        layout(legend = list(orientation = "h", y = 1.1,
                             title = list(text="Scenarios")),
               margin = list(t = 60)
               )
      
      }
    
  })
  
}