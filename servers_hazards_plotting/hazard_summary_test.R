
# school filtering, reactive to t
school_filtered <- function(data, input_school) {
  data %>%
    filter(SchoolName %in% c(input_school)) %>%
    pivot_longer(cols = c(whp, heat_score, precip_score, flood_score, slr_score), 
                 names_to = "variable", values_to = "value")
}

# generate hazard summary plot
generate_hazard_summary_plot <- function(filtered_data) {
  ggplot(filtered_data, aes(y = variable, x = value)) +
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
    labs(y = NULL, x = NULL, title = "Dos Pueblos High Hazard Summary")
}
