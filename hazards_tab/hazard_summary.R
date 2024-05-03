fluidRow(
  tags$style(".nav-tabs-custom {box-shadow:none;}"),
  
  # box for plot output
  box(
    width = 6,
    # hazard summary plot output -----
    plotOutput(outputId = "hazard_summary")
  ),
  
  # box for picker input
  box(
    width = 3,
    pickerInput(inputId = "school_input",
                label = "select school",
                choices = unique(sb_hazards_test$SchoolName),
                options = pickerOptions(actionsBox = TRUE),
                multiple = FALSE)
  ),
  
  # text column
  column(
    width = 3,
    box(
      width = NULL,
      
      # Load text in 
      includeMarkdown("text/summary.md")
      
    )
  )
  
)
