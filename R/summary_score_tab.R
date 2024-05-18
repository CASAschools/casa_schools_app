summary_score_tab <- function(input) {
  
  # filter school as input for summary tab plot
  hazards_filtered <- reactive({
    school_filtered(hazards_test, input$district, input$school_summary)
  })
  
  # update summary score based on the input
  renderUI({
    # make sure there's a selection, outputting a message if there is none
    h3(tags$strong(paste("Total Score:", hazards_filtered()$hazard_score)))
  })
  
}