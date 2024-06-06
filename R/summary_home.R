# generate hazard summary plot for the homepage
summary_home <- function(input) {
  
  # filter school as input for homepage plot
  hazards_filtered <- reactive({
    req(input$district, input$school)
    school_filtered(hazards_test, input$district, input$school)
  })
  
  # render hazard summary plot
  renderPlot({
    
    ## lollipop chart of individual hazards -----
    # pivot longer to create dataframe for the lollipop plot
    lollipop_df <- hazards_filtered() %>%
      pivot_longer(cols = c(heat_score, whp, precip_score, flood_score, slr_score),
                   names_to = "variable", values_to = "value") %>% 
      mutate(variable = factor(variable, levels = c("slr_score", "flood_score", "precip_score", "whp", "heat_score")))
    
    lollipop_chart <- ggplot(lollipop_df, 
                             aes(y = variable, x = value)) +
      # create a segment, the length of which corresponds to the hazard score
      geom_segment(aes(y = variable, yend = variable, x = -.4, xend = value),
                   color = "skyblue",
                   size = 3) +
      # add a point at the end of the segment
      geom_point(aes(fill = value),
                 size = 12,
                 shape = 21,
                 color = "black",
                 alpha = .9) +
      # add hazard score as a label to the point
      geom_text(aes(label = value), vjust = 0.5, hjust = 0.5, 
                color = "black", size = 6, fontface = "bold", family = "sans") +
      # make sure x-axis draws from -0.4 to 5
      scale_x_continuous(limits = c(-0.4, 5)) +
      # map a gradient fill from green to red for the hazard summary points
      scale_fill_gradientn(colors = custom_pal,
                           limits = c(0,5)) +
      theme_light(base_family = "sans") +
      # add custom labels to change the lollipop labels from the shorthand column names
      scale_y_discrete(labels = hazard_labels,
                       expand = c(0.1, 0.3)) +
      theme(panel.grid.major.y = element_blank(), # remove y-axis grid lines
            # remove panel border
            panel.border = element_blank(),
            # remove y-axis grid lines
            panel.grid.minor.y = element_blank(),
            # remove minor x-axis grid lines
            panel.grid.minor.x = element_blank(),
            # remove legend
            legend.position = "none",
            # customize y-axis label text
            axis.text.y = element_text(size = 16, color = "black", family = "sans", 
                                       margin = margin(r = -10)),
            axis.text.x = element_text(size = 12),
            # remove y-axis ticks
            axis.ticks.y = element_blank(),
            # increase plot margins
            plot.margin = unit(c(0.1, 0, 0.1, 0), "cm")) +
      labs(y = NULL,
           x = NULL)
    
    ## create label plot -----
    risk_label <- ggplot() + 
      # add lower risk label
      annotate("text", x = 0, y = 0.5, label = "lower risk", hjust = -2.7, 
               size = 5, family = "sans") + 
      # add higher risk label
      annotate("text", x = 1, y = 0.5, label = "higher risk", hjust = .8, 
               size = 5, family = "sans") +
      # draw an arrow between the two labels
      annotate("segment", x = 0.5, xend = 0.85, y = 0.5, yend = 0.5,
               arrow = arrow(length = unit(0.3, "cm"), type = "closed")) +
      # remove background axis and text elements
      theme_void() +
      # increase plot margins
      theme(plot.margin = unit(c(0.3, 0, 0.3, 0), "cm"))
    
    ## stitch them all together -----
    grid.arrange(lollipop_chart, risk_label, ncol = 1,
                 heights = c(1.8, .5))
    
  })
  
}
