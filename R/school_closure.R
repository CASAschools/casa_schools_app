school_closure <- function(input,output) {
  
  # filter school as input for homepage plot
  closure_filtered <- reactive({
    req(input$district, input$school)
    school_filtered(calmatters, input$district, input$school)
  })
  
  renderPlot({
    if (!is.na(closure_filtered()$total_days)){
      
    # Create text grab for school days
    text_grob <- textGrob(
      label = paste(closure_filtered()$total_days, "Days", collapse = "\n"),
      x = 0.1, y = 0.5, just = "left",
      gp = gpar(fontsize = 22, fontface = "bold")
    )
    
    # Read the image
    img_path <- "www/school_closed.png" # Replace with the path to your image file
    img <- image_read(img_path)
    img_grob <- rasterGrob(img, interpolate = TRUE)
    
    # Create title grob
    title_grob <- textGrob(
      label = "Number of Days Closed due to 
  Extreme Hazard Events",
  gp = gpar(fontsize = 20, fontface = "bold"),
  y = -.4
    )
    
    # Combine the title, image, and text using arrangeGrob
    combined <- arrangeGrob(
      title_grob, 
      arrangeGrob(img_grob, text_grob, ncol = 2, widths = c(1, 2)),
      ncol = 1,
      heights = c(0.2, 1) # Adjust the heights as needed
    )
    
    # Display the combined plot
    grid.arrange(combined)
    }
  
  else{
    plot.new()
  }
  })
}
  