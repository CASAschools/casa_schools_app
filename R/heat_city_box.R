heat_city_box <- function(input){
  
  filtered_schools <- reactive({
    
    school_points %>% filter(City == input$heat_city_input)
    
  })
  
  
}