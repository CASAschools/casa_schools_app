server <- function(input, output){
  
  #------------------- Hazards plot ---------------------------------------------
  
  # source script that filters the hazard scores dataframe and creates a plot
  source("servers_hazards_plotting/hazard_summary_test.R")
  
  # output hazard summary plot
  output$hazard_summary <- renderPlot({
    filtered_data <- school_filtered(sb_hazards_test, input$school_input)
    generate_hazard_summary_plot(filtered_data)
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

  output$precip <- renderPlot({
    source("servers_hazards_plotting/extreme_precipitation.R",
           local = TRUE,
           echo = FALSE, 
           print.eval = FALSE)[1]})  
  
    
#---------------------Wildfire--------------------------------------------------
    
  output$wildfire <- renderPlot({
    source("servers_hazards_plotting/wildfire.R",
           local = TRUE,
           echo = FALSE, 
           print.eval = FALSE)[1]})  

#---------------------Flooding--------------------------------------------------
    
  # pick a school
  dp_sr_high <- schools %>% 
    filter(CDSCode == 42767864231726)
  
  # grab the flooding polgons that intersect with that school area
  dp_sr_high_flood <- FEMA_reclass[dp_sr_high, ]
  
  #intersect flooding polygons so only the extent within school area is shown
  dp_sr_high_intersected <- st_intersection(dp_sr_high, dp_sr_high_flood)
  
  # plot it
  tmap_mode("view")
  
  flood <- tm_shape(dp_sr_high_intersected) +
    tm_polygons(fill = "flood_risk",
                title = "Flood Risk",
                labels = c("High", "Moderate to Low", "Undetermined"),
                palette = c("#0C46EE", "#AEDBEA", "#8DB6CD"), style = "pretty",
                alpha = 0.5) +
    tm_shape(dp_sr_high_flood, alpha = 0.5) + 
    tm_polygons(fill = "flood_risk", alpha = 0.5, legend.show=FALSE, 
                palette = c("#0C46EE", "#AEDBEA", "#8DB6CD"), style = "pretty")
#---------------------Coastal Flooding------------------------------------------
    
  output$coastal <- renderPlot({
    source("servers_hazards_plotting/coastal_inundation.R",
           local = TRUE,
           echo = FALSE, 
           print.eval = FALSE)[1]})  
  


# build leaflet map


  # output$map <- renderLeaflet({
  #   leaflet() %>% 
  #     addTiles() %>%
  #     setView(lng = -122.4194, lat = 37.7749, zoom = 10) %>%
  #     #addMarkers(data = school_points) %>% 
  #     addProviderTiles("OpenStreetMap")
  # })
  # Reactive output for district based on selected city
  
  #Here, we will create the output variables that feed into outputs used in the ui.R file
  output$districtMenu <- renderUI({
    req(input$city)
    selectInput("district", "Choose a district:", 
                choices = unique(school_points$DistrictNa[school_points$City== input$city]))
  })
  
  # Reactive output for school based on selected district
  output$schoolMenu <- renderUI({
    req(input$district)
    selectInput("school", "Choose a school:", 
                choices = unique(school_points$SchoolName[school_points$DistrictNa == input$district]))
  })
  
  # Render Leaflet map
  output$map <- renderLeaflet({
    req(input$school)
    selectedSchool <- school_points[school_points$SchoolName == input$school, ]
    leaflet(data = selectedSchool) %>%
      addTiles() %>%
      addMarkers(~Longitude, ~Latitude, popup = ~SchoolName)
  })
}
 
