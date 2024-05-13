server <- function(input, output, session){
  
  #-------------------Reactive school filtering--------------------------------
  
  # school filtering function to get around schools in different districts sharing the same name
  school_filtered <- function(schools, district, input_school) {
    # filter for the selected district first
    district_filter <- filter(schools, DistrictNa %in% c(district))
    # filter for the selected school within that district
    district_filter %>% 
      filter(SchoolName %in% c(input_school))
  }
  
  
  # update hazards tab title based on the selected school
  output$school_name <- renderUI({
    # make sure there's a selection, outputting a message if there is none
    if (!is.null(input$school_wildfire) && input$school_wildfire != "") {
      h3(tags$strong(input$school_wildfire), style = "font-size: 20px")
    } else {
      h3(tags$strong("Select a school", style = "font-size: 20px"))
    }
  })
  
  # update Heat tab title based on the selected school
  output$school_name_heat <- renderUI({
    # make sure there's a selection, outputting a message if there is none
    if (!is.null(input$school_heat) && input$school_heat != "") {
      h3(tags$strong(input$school_heat), style = "font-size: 20px")
    } else {
      h3(tags$strong("Select a school", style = "font-size: 20px"))
    }
  })
  
  
  
  
  
  #-------------------Hazards plot---------------------------------------------
  
  # source script that filters the hazard scores dataframe and creates a plot
  source("servers_hazards_plotting/hazard_summary_test.R")
  
  # filter school hazard summary table based on welcome page district input and hazards tab school input
  hazards_filtered <- reactive({
    school_filtered(hazards_test, input$district, input$school_wildfire)
  })
  
  
  # render hazard summary plot based on the selected school
  output$hazard_summary <- renderPlot({
    hazard_summary_plot(hazards_filtered())
  })
  
  #--------------------Extreme Heat ---------------------------------------------
  
  heat_filtered <- reactive({
    school_filtered(extreme_heat, input$district, input$school_heat)
  })
  
  output$extreme_heat_plotly <- renderPlotly({extreme_heat_plot(heat_filtered())})
  
  
  #--------------------Extreme Precipitation-------------------------------------
  
  output$extreme_precipitation_plotly <- extreme_precip_plot(input)
  
  #---------------------Wildfire--------------------------------------------------
  
  # filter school buffers based on welcome page district input and hazards tab school input
  buffers_filtered <- reactive({
    school_filtered(hazards_buffer, input$district, input$school_wildfire)
  })
  
  # render wildfire map based on the chosen school
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

  # City selection UI
  output$cityMenu <- renderUI({
    selectInput("city", "Choose a city:", choices = unique(hazards_buffer$City))
  })
  
  # District selection UI based on selected city
  output$districtMenu <- renderUI({
    req(input$city)  # requires city input
    valid_districts <- unique(hazards_buffer$DistrictNa[hazards_buffer$City == input$city])
    selectInput("district", "Choose a district:", choices = valid_districts)
  })
  
  # School selection UI based on selected district
  output$schoolMenu <- renderUI({
    req(input$district)  #requires district input
    valid_schools <- unique(hazards_buffer$SchoolName[hazards_buffer$DistrictNa == input$district & hazards_buffer$City == input$city])
    selectInput("school", "Choose a school:", choices = valid_schools)
  })
  
  # Render Leaflet map for the selected school
  output$map <- renderLeaflet({
    req(input$school, input$city, input$district)  #require all selections
    # Filter schools based on both district and city
    selectedSchool <- hazards_buffer[
      hazards_buffer$SchoolName == input$school &
        hazards_buffer$DistrictNa == input$district &
        hazards_buffer$City == input$city, 
    ]
    
    if (nrow(selectedSchool) == 1) {  #match to only one school or return empty map
      leaflet(data = selectedSchool) %>%
        addTiles() %>%
        setView(lng = selectedSchool$Longitude[1], lat = selectedSchool$Latitude[1], zoom = 13) %>% 
        # Add a circle marker with buffer around the school
        addCircles(~Longitude, ~Latitude, radius = 4828.03, #Adjust the radius as needed
                   popup = ~HazardString, color = ~binpal(hazard_score))
    } else {
      leaflet() %>%  #empty map return
        addTiles() %>%
        addPopups()
    }
  })
  
  # --------- update inputs of buttons based on each other -----------------------
  
  # update the welcome page school selection based on the hazards tab school selection
  observeEvent(input$school, {
    updateSelectInput(session, "school_wildfire", selected = input$school)
  })
  
  # update the extreme heat school selection based on the welcome page school selection
  observeEvent(input$school_heat, {
    updateSelectInput(session, "school", selected = input$school_heat)
  })
  
  # update the hazards tab school selection based on the welcome page school selection
  observeEvent(input$school_wildfire, {
    updateSelectInput(session, "school", selected = input$school_wildfire)
  })
  
  # #Update district_input pickerInput based on selected district
  # observeEvent(input$district, {
  #   updatePickerInput(session, "district_input", selected = input$district)
  # })
  
  # limit the hazards tab school selection dropdown to only be the schools in the district chosen on the welcome page
  observeEvent(input$district, {
    # subsets the schools where the district name matches the district input on the welcome page 
    valid_schools <- unique(hazards_buffer$SchoolName[hazards_buffer$DistrictNa == input$district])
    updateSelectInput(session, "school_wildfire", choices = valid_schools, selected = NULL)
  })
  
  # limit the hazards tab school selection dropdown to only be the schools in the district chosen on the welcome page
  observeEvent(input$district, {
    # subsets the schools where the district name matches the district input on the welcome page 
    valid_schools <- unique(extreme_heat$SchoolName[extreme_heat$DistrictNa == input$district])
    updateSelectInput(session, "school_heat", choices = valid_schools, selected = NULL)
  })
  
  
  # 
  # observeEvent(input$district_input, {
  #   valid_schools <- unique(hazards_buffer$SchoolName[hazards_buffer$DistrictNa == input$district_input])
  #   updatePickerInput(session, "school_wildfire", choices = valid_schools, selected = NULL)
  # })
  
} 


