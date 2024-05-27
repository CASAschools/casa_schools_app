server <- function(input, output, session){
  
  #-------------------Hazards plots---------------------------------------------
  
  # output hazard summary plot for the homepage
  output$summary_home <- summary_home(input)
  
  # output summary score as the header on the homepage
  output$summary_title_home <- summary_title_home(input)
    
  # output hazard summary plot for the summary tab
  output$summary_tab <- summary_tab(input)
  
  # output hazard summary score as the header on the summary tab
  output$summary_score_tab <- summary_score_tab(input)

  #--------------------Extreme Heat ---------------------------------------------
  
  # output extreme heat plot
  output$heat_plot <- heat_plot(input)

  #--------------------Extreme Precipitation-------------------------------------
  
  # output extreme precipitation plot
  output$precip_plot <- precip_plot(input)
  
  #---------------------Wildfire--------------------------------------------------
  
  # output wildfire map for 2023
  output$wildfire_map2023 <- wildfire_map2023(input)
  
  # output wildfire map for 2012
  output$wildfire_map2012 <- wildfire_map2012(input)
  
  #---------------------Flooding--------------------------------------------------
  
  # output flood map
  output$flood_map <- flood_map(input)
  
  #---------------------Sea Level Rise----------------------------------------
  
  # output sea level rise map
  output$slr_map <- slr_map(input)
  
  # output sea level rise 2000 map
  output$slr_map_2000 <- slr_map_2000(input)
  
  #---------------------Homepage leaflet map------------------------------------

  # # City selection UI
  # output$cityMenu <- renderUI({
  #   selectInput("city", "Choose a city:", choices = unique(hazards_buffer$City))
  # })
  
  # test version with no default value
  output$cityMenu <- renderUI({
    selectInput(inputId = "city", 
                label = "Select or type a city", 
                choices = sort(unique(hazards_buffer$City)), 
                selected = NULL)
  })
  
  # District selection UI based on selected city
  output$districtMenu <- renderUI({
    req(input$city)  # requires city input
    valid_districts <- unique(hazards_buffer$DistrictNa[hazards_buffer$City == input$city])
    selectInput(inputId = "district", 
                label = "Select or type a school district", 
                choices = sort(valid_districts),
                selected = NULL)
  })
  
  # School selection UI based on selected district
  output$schoolMenu <- renderUI({
    req(input$district)  #requires district input
    valid_schools <- unique(hazards_buffer$SchoolName[hazards_buffer$DistrictNa == input$district])
    selectInput(inputId = "school", 
                label = "Select or type a school", 
                choices = sort(valid_schools),
                selected = NULL)
  })
  
  # Render Leaflet map for the selected school
  output$map <- renderLeaflet({
    req(input$school, input$district)  # require school and district inputs
    # Filter schools based on both district
    selectedSchool <- hazards_buffer[
      hazards_buffer$SchoolName == input$school &
        hazards_buffer$DistrictNa == input$district,
    ]
    
    if (nrow(selectedSchool) == 1) {  #match to only one school or return empty map
      leaflet(data = selectedSchool) %>%
        addProviderTiles(providers$Esri.WorldTopoMap, group = "topographic map") %>% 
        setView(lng = selectedSchool$Longitude[1], lat = selectedSchool$Latitude[1], zoom = 11) %>% 
        # Add a circle marker with buffer around the school
        addCircles(~Longitude, ~Latitude, radius = 4828.03, color = "black", fill = FALSE, weight = 2) %>%  #Adjust the radius as needed
        addAwesomeMarkers(~Longitude, ~Latitude, popup = ~HazardString, icon = ~markers) %>% 
        addMarkers(~Longitude, ~Latitude, icon = ~icons, popup = ~HazardString) %>% 
        addScaleBar(position =  "bottomleft")
    } else {
      leaflet() %>%  #empty map return
        addTiles() %>%
        addPopups()
    }
  })
  
  # --------- update inputs of buttons based on each other -----------------------
 
   # limit the schools selection in buttons based on the selected district
  valid_schools <- reactive({
    unique(hazards_buffer$SchoolName[hazards_buffer$DistrictNa == input$district])
  })
  
  # update hazard summary pages and hazard pages buttons based on initial school selection
  observeEvent(input$school, {
    updateSelectInput(session, "school_summary",
                      choices = valid_schools(), selected = input$school)
    updateSelectInput(session, "school_heat",
                      choices = valid_schools(), selected = input$school)
    updateSelectInput(session, "school_wildfire",
                      choices = valid_schools(), selected = input$school)
    updateSelectInput(session, "school_precip",
                      choices = valid_schools(), selected = input$school)
    updateSelectInput(session, "school_flooding",
                      choices = valid_schools(), selected = input$school)
    updateSelectInput(session, "school_slr",
                      choices = valid_schools(), selected = input$school)

  })
  
  # store selected school as a reactive value
  selected_school <- reactiveVal()
  
  # update selected_school based on inputs, and output school name based on school dropdown selection
  observeEvent(input$school_summary, {
    # update selected school
    selected_school(input$school_summary)
    # update school name output for the hazard summary tab
    output$school_name_summary <- update_school_name(selected_school())
  })
  
  observeEvent(input$school_heat, {
    # update selected school
    selected_school(input$school_heat)
    # update school name output for the extreme heat tab
    output$school_name_heat <- update_school_name(selected_school())
  })
  
  observeEvent(input$school_wildfire, {
    # update selected school
    selected_school(input$school_wildfire)
    # update school name output for the wildfire tab
    output$school_name_wildfire <- update_school_name(selected_school())
  })
  
  observeEvent(input$school_precip, {
    # update selected school
    selected_school(input$school_precip)
    # update school name output for the precipitation tab
    output$school_name_precip <- update_school_name(selected_school())
  })
  
  observeEvent(input$school_flooding, {
    # update selected school
    selected_school(input$school_flooding)
    # update school name output for the flooding tab
    output$school_name_flood <- update_school_name(selected_school())
  })
  
  observeEvent(input$school_slr, {
    # update selected school
    selected_school(input$school_slr)
    # update school name output for the sea level rise tab
    output$school_name_slr <- update_school_name(selected_school())
  })
  
  # Update all select inputs based on the reactive value of selected school
  observe({
    updateSelectInput(session, "school_summary",
                      choices = valid_schools(), selected = selected_school())
    updateSelectInput(session, "school_heat",
                      choices = valid_schools(), selected = selected_school())
    updateSelectInput(session, "school_wildfire",
                      choices = valid_schools(), selected = selected_school())
    updateSelectInput(session, "school_precip",
                      choices = valid_schools(), selected = selected_school())
    updateSelectInput(session, "school_flooding",
                      choices = valid_schools(), selected = selected_school())
    updateSelectInput(session, "school_slr",
                      choices = valid_schools(), selected = selected_school())
  })

# ---------------output tutorial images on each page---------------------
  
  # output tutorial image when the user clicks on the button in the hazard summary tab
  observeEvent(input$tutorial_summary, {
    showModal(modalDialog(
      title = NULL,
      img(src = "wildfire_tutorial.jpg",
          style = "width: 100%; height: auto;"),
      footer = modalButton("Close"),
      easyClose = TRUE,
      fade = TRUE,
      size = "l"
    ))
  })
  
  # output tutorial image when the user clicks on the button in the extreme heat tab
  observeEvent(input$tutorial_heat, {
    showModal(modalDialog(
      title = NULL,
      img(src = "wildfire_tutorial.jpg",
          style = "width: 100%; height: auto;"),
      footer = modalButton("Close"),
      easyClose = TRUE,
      fade = TRUE,
      size = "l"
    ))
  })
  
  # output tutorial image when the user clicks on the button in the wildfire tab
  observeEvent(input$tutorial_wildfire, {
    showModal(modalDialog(
      title = NULL,
      img(src = "wildfire_tutorial.jpg",
          style = "width: 100%; height: auto;"),
      footer = modalButton("Close"),
      easyClose = TRUE,
      fade = TRUE,
      size = "l"
    ))
  })
  
  # output tutorial image when the user clicks on the button in the precipitation tab
  observeEvent(input$tutorial_precip, {
    showModal(modalDialog(
      title = NULL,
      img(src = "wildfire_tutorial.jpg",
          style = "width: 100%; height: auto;"),
      footer = modalButton("Close"),
      easyClose = TRUE,
      fade = TRUE,
      size = "l"
    ))
  })
  
  # output tutorial image when the user clicks on the button in the flooding tab
  observeEvent(input$tutorial_flooding, {
    showModal(modalDialog(
      title = NULL,
      img(src = "wildfire_tutorial.jpg",
          style = "width: 100%; height: auto;"),
      footer = modalButton("Close"),
      easyClose = TRUE,
      fade = TRUE,
      size = "l"
    ))
  })
  
  # output tutorial image when the user clicks on the button in the sea level rise tab
  observeEvent(input$tutorial_slr, {
    showModal(modalDialog(
      title = NULL,
      img(src = "wildfire_tutorial.jpg",
          style = "width: 100%; height: auto;"),
      footer = modalButton("Close"),
      easyClose = TRUE,
      fade = TRUE,
      size = "l"
    ))
  })

} 


