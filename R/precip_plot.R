precip_plot <- function(input,output) {
  
  # filter data based on school
  precip_filtered <- reactive({
    school_filtered(extreme_precip, input$district, input$school_precip)
  })
  
  renderPlotly({
      precip_bar <- ggplot(data = precip_filtered(),
                         aes(x = year, y = total, fill = scenario)) +
        geom_bar(stat = "identity", position = "dodge") +
        theme_classic() +
        labs(x = "Year",
             y = "Number of Days",
             title = "Number of Extreme Precipitation Days") +
        theme(legend.position = "top",
              legend.title = element_blank()) +
        scale_x_continuous(breaks = seq(2005, 2064, by = 5)) +
        scale_fill_manual(values = c("High greenhouse gas emissions"= "cornflowerblue", 
                                     "Reduced greenhouse gas emissions"= "#B8E3FF"))
      
      precip_bar_plt <- plotly::ggplotly(precip_bar) %>% 
        layout(legend = list(orientation = "h", y = 1.1,
                             title = list(text = 'Scenarios')),
               margin = list(t = 60),
               barmode = "grouped")
      
      
    })
    
  }