precip_plot <- function(input,output) {
  
  # filter data based on school
  precip_filtered <- reactive({
    school_filtered(extreme_precip, input$district, input$school_precip)
  })
  
  renderPlotly({
    if(input$change_precip_plot[[1]] %in% "Bar plot"){
      # Output plot
      precip_bar <- ggplot(data = precip_filtered(),
                         aes(x = year, y = total, fill = scenario)) +
        geom_bar(stat = "identity", position = "dodge") +
        theme_classic() +
        labs(x = "Year",
             y = "Number of Days",
             title = "Number of Extreme Precipitation Days") +
        theme(legend.position = "top",
              legend.title = element_blank()) +
        scale_fill_manual(values = c("High greenhouse gas emissions"= "#ff0000", 
                                     "Reduced greenhouse gas emissions"= "#ffc100"))
      
      precip_bar_plt <- plotly::ggplotly(precip_bar) %>% 
        layout(legend = list(orientation = "h", y = 1.1,
                             title = list(text = 'Scenarios')),
               margin = list(t = 60),
               barmode = "grouped")
      
      
    }
    else if(input$change_precip_plot[[1]] %in% "Line graph") {
      
      precip_line <- ggplot(data = precip_filtered(),
                          aes(x = year, y = total, color = scenario)) +
        geom_smooth(method = "lm", se = FALSE) +
        theme_classic() +
        labs(x = "Year",
             y = "Number of Days",
             title = "Trend of Extreme Precipitation Days") +
        theme(legend.position = "top",
              legend.title = element_blank()) +
        scale_color_manual(values = c("High greenhouse gas emissions"= "#ff0000", 
                                      "Reduced greenhouse gas emissions"= "#ffc100"))
      
      precip_line_plt <- plotly::ggplotly(precip_line) %>% 
        style(hoverinfo = 'none') %>% 
        layout(legend = list(orientation = "h", y = 1.1,
                             title = list(text="Scenarios")),
               margin = list(t = 60)
        )
      
    }
    
  })
  
}