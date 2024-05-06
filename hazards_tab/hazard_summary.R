fluidRow(
  tags$style(".nav-tabs-custom {box-shadow:none;}"),
  
  # box for plot output
  box(
    width = 6,
    # hazard summary plot output -----
    plotOutput(outputId = "hazard_summary")
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
