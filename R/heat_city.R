heat_city <- function(inputId){
  
  selectInput(inputId = inputId,
    label = "City",
    choices = unique(school_points$SchoolName),
    selected = NULL,
    multiple = FALSE,
    width = "140px"
  )
  
}