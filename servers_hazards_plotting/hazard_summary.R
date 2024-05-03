

school_filtered <- reactive({
  
  sb_hazards_test %>% 
    filter(SchoolName %in% c(input$school_input)) %>% 
    pivot_longer(cols = c(whp, heat_score, precip_score, flood_score, slr_score), 
                 names_to = "variable", values_to = "value")
  
})

output$hazard_summary <- renderPlot({
  
  ggplot(school_filtered(), aes(y = variable, x = value)) +
    # create a segment, the length of which corresponds to the hazard score
    geom_segment(aes(y = variable, yend = variable, x = 0, xend = value), 
                 color = "skyblue",
                 size = 3) +
    # add a point at the end of the segment
    geom_point(aes(fill = value), 
               size = 12, 
               shape = 21, 
               color = "black",
               alpha = .9) +
    # add hazard score as a label to the point
    geom_text(aes(label = value), vjust = 0.5, hjust = 0.5, color = "black", size = 4) +
    # map a gradient fill from green to red for the hazard summary points
    scale_fill_gradientn(colors = green_red,
                         limits = c(1,5),
                         breaks = c(1:5)) +
    theme_light() +
    # add custom labels to change the lollipop labels from the shorthand column names
    scale_y_discrete(labels = hazard_labels) +
    theme(panel.grid.major.y = element_blank(),
          panel.border = element_blank(),
          # remove legend
          legend.position = "none") +
    labs(y = NULL,
         x = NULL,
         title = "Dos Pueblos High Hazard Summary")
  
})
