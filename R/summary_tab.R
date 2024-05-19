# generate hazard summary plot for the summary tab
summary_tab <- function(input) {
  
  # filter school as input for summary tab plot
  hazards_filtered <- reactive({
    school_filtered(hazards_test, input$district, input$school_summary)
  })

  # render hazard summary plot
  renderPlot({
    
    ## lollipop chart of individual hazards -----
    # pivot longer to create dataframe for the lollipop plot
    lollipop_df <- hazards_filtered() %>%
      pivot_longer(cols = c(whp, heat_score, precip_score, flood_score, slr_score),
                   names_to = "variable", values_to = "value")
    
    lollipop_chart <- ggplot(lollipop_df, 
                             aes(y = reorder(variable, value), x = value)) +
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
      geom_text(aes(label = value), vjust = 0.5, hjust = 0.5, 
                color = "black", size = 6, fontface = "bold", family = "sans") +
      # make sure x-axis draws to 5
      scale_x_continuous(limits = c(0,5)) +
      # map a gradient fill from green to red for the hazard summary points
      scale_fill_gradientn(colors = custom_pal,
                           limits = c(1,5),
                           breaks = c(1:5)) +
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
    
    ## bar chart of total hazard summary score -----
    total_score <- ggplot(hazards_filtered()) +
      # compose the bar of 5 rectangles corresponding to the color scheme (lower to higher risk)
      geom_rect(aes(xmin = 0, xmax = 5, ymin = 0.5, ymax = 1.2), 
                fill = "#FFCF73", alpha = .7) +
      geom_rect(aes(xmin = 5, xmax = 10, ymin = 0.5, ymax = 1.2), 
                fill = "#F2EAAB", alpha = .7) +
      geom_rect(aes(xmin = 10, xmax = 15, ymin = 0.5, ymax = 1.2), 
                fill = "#8FD2E3", alpha = .7) +
      geom_rect(aes(xmin = 15, xmax = 20, ymin = 0.5, ymax = 1.2), 
                fill = "#6B9EB8", alpha = .7) +
      geom_rect(aes(xmin = 20, xmax = 25, ymin = 0.5, ymax = 1.2), 
                fill = "#5A5E9E", alpha = .7) +
      # plot a red line on the bar corresponding to the overall hazard score
      geom_segment(aes(y = 0.2, yend = 1.5, x = hazard_score, xend = hazard_score),
                   color = "red",
                   linewidth = 1.5) +
      # set the x-axis limits
      xlim(0, 25) +
      # remove axis labels
      labs(y = NULL,
           x = NULL) +
      theme_minimal() +
      theme(aspect.ratio = 1/10, # adjust the aspect ratio
            # increase size of x-axis numbers
            axis.text.x = element_text(size = 12),
            # remove x-axis grid lines
            panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank(),
            # remove y-axis grid lines
            panel.grid.major.y = element_blank(),
            panel.grid.minor.y = element_blank(),
            axis.text.y = element_blank(),
            # increase plot margins
            plot.margin = unit(c(0.1, 0, 0.1, 0), "cm"))
    
    ## create label plot -----
    risk_label <- ggplot() + 
      # add lower risk label
      annotate("text", x = 0, y = 0.5, label = "lower risk", hjust = -1.4, 
               size = 5, family = "sans") + 
      # add higher risk label
      annotate("text", x = 1, y = 0.5, label = "higher risk", hjust = 1, 
               size = 5, family = "sans") +
      # draw an arrow between the two labels
      annotate("segment", x = 0.35, xend = 0.8, y = 0.5, yend = 0.5,
               arrow = arrow(length = unit(0.3, "cm"), type = "closed")) +
      # remove background axis and text elements
      theme_void() +
      # increase plot margins
      theme(plot.margin = unit(c(0.3, 0, 0.3, 0), "cm"))
    
    ## stitch them all together -----
    grid.arrange(total_score, lollipop_chart, risk_label, ncol = 1,
                 heights = c(.8, 1.8, .5))
    
  })
  
}