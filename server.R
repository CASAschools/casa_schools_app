server <- function(input, output){
  
  #-------------------Reactive school filtering--------------------------------
  
  # school filtering function
  school_filtered <- function(schools, input_school) {
    schools %>% 
      filter(SchoolName %in% c(input_school))
  }
  
  
  # Update hazards tab title based on the selected school
  output$school_name <- renderUI({
    # make sure there's a selection, outputting a message if there is none
    if (!is.null(input$school_input) && input$school_input != "") {
      h2(tags$strong(input$school_input))
    } else {
      h2(tags$strong("Select a school"))
    }
  })
  
  #-------------------Hazards plot---------------------------------------------
  
  # source script that filters the hazard scores dataframe and creates a plot
  source("servers_hazards_plotting/hazard_summary_test.R")
  
  # filter school to build hazard summary plot 
  hazards_filtered <- reactive({
    school_filtered(sb_hazards_test, input$school_input)
  })
  
  # output hazard summary plot
  output$hazard_summary <- renderPlot({
    hazard_summary_plot(hazards_filtered())
  })
  
  #--------------------Extreme Heat ---------------------------------------------
  
  output$extreme_heat <- renderPlotly({
    # Develop plot 
    heat <- ggplot(data = extreme_heat1,
                   aes(x = year, y = total, color = scenario)) +
      geom_line() +
      theme_classic() +
      labs(x = "Year",
           y = "Number of Extreme Heat Days") +
      theme(legend.position = "top",
            legend.title = element_blank())
    
    ggplotly(heat) %>%
      layout(legend = list(orientation = "h", y = 1.1,
                           title = list(text = 'Scenarios')),
             margin = list( t = 60))
    
  })
  
  
  #--------------------Extreme Precipitation-------------------------------------
  
  output$extreme_precip1 <- renderPlotly({
    # Develop plot 
    heat <- ggplot(data = extreme_precip1,
                   aes(x = year, y = total, color = scenario)) +
      geom_line() +
      theme_classic() +
      labs(x = "Year",
           y = "Number of Extreme Precipitation Days") +
      theme(legend.position = "top",
            legend.title = element_blank())
    
    ggplotly(heat) %>%
      layout(legend = list(orientation = "h", y = 1.1,
                           title = list(text = 'Scenarios')),
             margin = list( t = 60))
    
  })
  
  
  #---------------------Wildfire--------------------------------------------------
  
  # filter school to build wildfire 
  buffers_filtered <- reactive({
    school_filtered(schools_buffers, input$school_input)
  })
  
  # Render the map in the UI
  output$wildfire_map <- renderLeaflet({
    wildfire_map(buffers_filtered())
  })
  
  #---------------------Flooding--------------------------------------------------
  
  output$flooding <- renderPlot({
    source("servers_hazards_plotting/flooding.R",
           local = TRUE,
           echo = FALSE, 
           print.eval = FALSE)[1]})  
  
  #---------------------Coastal Flooding----------------------------------------
  
  output$coastal <- renderPlot({
    source("servers_hazards_plotting/coastal_inundation.R",
           local = TRUE,
           echo = FALSE, 
           print.eval = FALSE)[1]})  
  
  
  
  #---------------------Homepage leaflet map------------------------------------
  
  
  # output$map <- renderLeaflet({
  #   leaflet() %>% 
  #     addTiles() %>%
  #     setView(lng = -122.4194, lat = 37.7749, zoom = 10) %>%
  #     #addMarkers(data = school_points) %>% 
  #     addProviderTiles("OpenStreetMap")
  # })
  # Reactive output for district based on selected city
  
  #Create reactive map that filters for City, School District, and Schools
  
  # City selection UI
  output$cityMenu <- renderUI({
    selectInput("city", "Choose a city:", choices = unique(school_points$City))
  })
  
  # District selection UI based on selected city
  output$districtMenu <- renderUI({
    req(input$city)  # requires city input
    valid_districts <- unique(school_points$DistrictNa[school_points$City == input$city])
    selectInput("district", "Choose a district:", choices = valid_districts)
  })
  
  # School selection UI based on selected district
  output$schoolMenu <- renderUI({
    req(input$district)  #requires district input
    valid_schools <- unique(school_points$SchoolName[school_points$DistrictNa == input$district & school_points$City == input$city])
    selectInput("school", "Choose a school:", choices = valid_schools)
  })
  
  # Render Leaflet map for the selected school
  output$map <- renderLeaflet({
    req(input$school, input$city, input$district)  #require all selections
    # Filter schools based on both district and city
    selectedSchool <- school_points[
      school_points$SchoolName == input$school &
        school_points$DistrictNa == input$district &
        school_points$City == input$city, 
    ]
    
    if (nrow(selectedSchool) == 1) {  #match to only one school or return empty map
      leaflet(data = selectedSchool) %>%
        addTiles() %>%
        addMarkers(~Longitude, ~Latitude, popup = ~MarkerString)
    } else {
      leaflet() %>%  #empty map return
        addTiles() %>%
        addPopups()
    }
  })
} 

