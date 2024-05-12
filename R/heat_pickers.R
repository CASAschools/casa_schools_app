heat_pickers <- function(inputId){
  
    column(2,
           selectInput(
             inputId = "heat_city",
             label = "City",
             choices = unique(school_points$City),
             selected = NULL,
             multiple = FALSE,
             width = "140px")
    )
    column(4,
           selectInput(
             inputId = "heat_district",
             label = "School district",
             choices = unique(school_points$DistrictNa),
             selected = NULL,
             multiple = FALSE)
    )
    column(4,
           selectInput(
             inputId = "heat_school",
             label = "School",
             choices = unique(school_points$SchoolName),
             selected = NULL,
             multiple = FALSE
           ))
  
}