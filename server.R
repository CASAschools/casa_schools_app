server <- function(input, output, session){
  
  #-------------------Reactive school filtering--------------------------------
  
  # # school filtering function to get around schools in different districts sharing the same name
  # school_filtered <- function(schools, district, input_school) {
  #   # filter for the selected district first
  #   district_filter <- filter(schools, DistrictNa %in% c(district))
  #   # filter for the selected school within that district
  #   district_filter %>% 
  #     filter(SchoolName %in% c(input_school))
  # }
  
  
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
  
  
  #-------------------Hazards plots---------------------------------------------
  
  # output hazard summary plot for the homepage
  output$summary_homepage <- summary_plot_homepage(input)
  
  # output hazard summary plot for the summary tab
  output$summary_sumtab <- summary_plot_tab(input)

  #--------------------Extreme Heat ---------------------------------------------
  
  # output extreme heat plot
  output$extreme_heat_plotly <- extreme_heat_plot_test(input)

  #--------------------Extreme Precipitation-------------------------------------
  
  # output extreme precipitation plot
  output$extreme_precipitation_plotly <- extreme_precip_plot(input)
  
  #---------------------Wildfire--------------------------------------------------
  
  # output wildfire map
  output$wildfire_map <- wildfire_map(input)
  
  #---------------------Flooding--------------------------------------------------
  
  output$flooding <- renderPlot({
    source("servers_hazards_plotting/flooding.R",
           local = TRUE,
           echo = FALSE, 
           print.eval = FALSE)[1]})  
  
  #---------------------Sea Level Rise----------------------------------------
  
  # output sea level rise map
  output$slr_map <- slr_map(input)
  
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
    #updateSelectInput(session, "school_slr", selected = input$school_wildfire)
  })

  # limit the wildfire tab school selection dropdown to only be the schools in the district chosen on the welcome page
  observeEvent(input$district, {
    # subsets the schools where the district name matches the district input on the welcome page
    valid_schools <- unique(hazards_buffer$SchoolName[hazards_buffer$DistrictNa == input$district])
    updateSelectInput(session, "school_wildfire", choices = valid_schools, selected = NULL)
    #updateSelectInput(session, "school_slr", choices = valid_schools, selected = NULL)
  })

} 


