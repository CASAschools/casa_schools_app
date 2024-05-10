schoolpicked_valueBox <- function(input){
  
  # filter to school
  filter_school_city <- reactive({
    school_points %>% filter(City == input$school_city)
    
  })
  
}


