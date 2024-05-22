summary_title_home <- function(input) {
  
  # filter school as input for reactive text above hazard summary
  filtered_data <- reactive({
    school_filtered(hazards_test, input$district, input$school)
  })
  
  # update summary score based on the input
  renderUI({
    # make sure there's a selection, outputting a message if there is none
    h3(tags$strong(paste(filtered_data()$SchoolName, "hazard summary")))
  })
  
}