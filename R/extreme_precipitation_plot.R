extreme_precip_plot <- function(input,output) {
  extreme_precip_plotly <- renderPlotly({
    # Filter data based on school
    filtered_data <- subset(names_precip_merge, SchoolName == input$schoolPicker)
    precip <- ggplot(data = filtered_data,
                     aes(x = year, y = total, fill = scenario)) +
      geom_bar(stat = "identity", position = "dodge") +
      theme_classic() +
      labs(x = "Year",
           y = "Number of Extreme Precipitation Days") +
      theme(legend.position = "top",
            legend.title = element_blank())
    plotly::ggplotly(precip) %>%
      layout(legend = list(orientation = "h", y = 1.1, title = list(text = 'Scenarios')),
             margin = list(t = 60),
             barmode = "grouped")
  })
}
