# generate hazard summary plot
hazard_summary_plot <- function(hazards_filtered) {
  
  ## lollipop chart of individual hazards -----
  # pivot longer to create dataframe for the lollipop plot
  lollipop_df <- hazards_filtered %>%
    pivot_longer(cols = c(whp, heat_score, precip_score, flood_score, slr_score),
                 names_to = "variable", values_to = "value")
  
  # plot the lollipop chart
  lollipop_chart <- ggplot(lollipop_df, aes(y = variable, x = value)) +
    geom_segment(aes(y = variable, yend = variable, x = 0, xend = value), 
                 color = "skyblue",
                 size = 3) +
    geom_point(aes(fill = value), 
               size = 12, 
               shape = 21, 
               color = "black",
               alpha = .9) +
    geom_text(aes(label = value), vjust = 0.5, hjust = 0.5, color = "black", size = 4) +
    # make sure x-axis draws to 5
    scale_x_continuous(limits = c(0, 5)) +
    scale_fill_gradientn(colors = green_red,
                         limits = c(1,5),
                         breaks = c(1:5)) +
    theme_light() +
    scale_y_discrete(labels = hazard_labels) +
    theme(panel.grid.major.y = element_blank(),
          panel.border = element_blank(),
          legend.position = "none") +
    labs(y = NULL, x = NULL, title = "Hazard Summary")
  
  ## bar chart of total hazard summary score -----
  # composite score v2
  total_score <- ggplot(hazards_filtered, aes(y = as.factor(1))) +  # need to create a dummy y-axis
    geom_col(aes(x = 25), 
             fill = "lightyellow", 
             color = "black", 
             width = 0.8) + 
    # plot a red line at the value of the hazard score
    geom_segment(aes(y = 0.5, yend = 1.5, x = hazard_score, xend = hazard_score), 
                 color = "red",
                 linewidth = 1.5) +
    # label the hazard score
    geom_text(aes(x = hazard_score, y = 1, label = hazard_score), 
              hjust = -.2, color = "black", size = 8) +
    # set x limits for the column
    xlim(0, 25) + 
    labs(y = NULL,
         x = NULL, 
         title = "Total Score") +  # Adjust labels as necessary
    theme_minimal() +
    theme(aspect.ratio = 1/10, # adjust aspect ratio to move the plot title and x-axis labels closer
          panel.grid.major.x = element_blank(),  # Remove major grid lines for x-axis
          panel.grid.minor.x = element_blank(),  # Remove minor grid lines for x-axis
          panel.grid.major.y = element_blank(),  # Remove major grid lines for y-axis
          panel.grid.minor.y = element_blank(),
          axis.text.y = element_blank())
  
  ## create label plot -----
  risk_label <- ggplot() + 
    annotate("text", x = 0, y = 0.5, label = "Lower Risk", hjust = 0, size = 5) + 
    annotate("text", x = 1, y = 0.5, label = "Higher Risk", hjust = 1, size = 5) +
    theme_void() +
    theme(plot.margin = unit(c(0, 0, 0, 0), "lines"))
  
  ## stitch them all together -----
  grid.arrange(lollipop_chart, total_score, risk_label, ncol = 1, heights = c(2, .7, .1))
  
}
