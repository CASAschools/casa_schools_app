flood_map <- function(input) {
  
  # filter buffers based on school
  buffers_filtered <- reactive({
    school_filtered(hazards_buffer, input$district, input$school_flooding)
  })
  
  renderLeaflet({
    
    # filter school buffers for school name
    selected_school <- buffers_filtered()
    
    # create school point based on centroid of buffer
    selected_school_point <- selected_school %>% 
      st_centroid()
    
    #clip school buffers to flood intersections
    FEMA_schools <- st_intersection(selected_school, FEMA_reclass_simple)
    
    #intersect the school buffer with flood risk
    selected_flood_intersected <- st_intersection(selected_school, FEMA_reclass_simple)
    
    # overlay the school buffer and school point on the FEMA flood risk shapefile
    # plot it
    selected_school <- st_transform(selected_school, crs = 4326)
    selected_school_point <- st_transform(selected_school_point, crs = 4326)
    FEMA_schools <- st_transform(FEMA_schools, crs = 4326)
    
    
    # define color palette and labels for FEMA flood zone classification
    labels <- c("High", "Moderate to Low", "Undetermined")
    flood_colors <- colorFactor(c("#0C46EE", "#AEDBEA", "#808080"), levels = c("high", "moderate to low", "undetermined"))
    flood_palette <- colorFactor(palette = flood_colors,
                                 domain = selected_flood_intersected$flood_risk)
    
  
    # leaflet map of flood risk potential
    leaflet(options = leafletOptions(attributionControl = FALSE)) %>% 
      
      # add topo basemap
      addProviderTiles(providers$Esri.WorldTopoMap, group = "topographic map") %>%
      
      # add imagery basemap
      addProviderTiles(providers$Esri.WorldImagery, group = "satellite imagery") %>% 
      
      # add cropped flood risk
      addPolygons(data = FEMA_schools, fillColor = c("#0C46EE", "#AEDBEA", "#808080"),  fillOpacity = .8, group = "flood risk", stroke = FALSE) %>% 
      
      # add school buffer polygon
      addPolygons(data = selected_school, color = "darkgrey", fill = FALSE, 
                  weight = 2, group = "school community area") %>% 
      
      # add school point
      addCircleMarkers(data = selected_school_point, color = "black", stroke = FALSE, 
                       weight = 10, radius = 5, fillOpacity = 1,
                       group = "school point") %>% 
      
      # add legend for flood risk with custom labels
      addLegend("bottomright", colors = c("#0C46EE", "#AEDBEA", "#808080"), labels = labels,
                title = "Flood Risk", opacity = 0.8) %>% 
      
      # add a scale bar
      addScaleBar(position = "bottomleft",
                  options = scaleBarOptions(imperial = TRUE,
                                            metric = FALSE,
                                            maxWidth = 200)) %>% 
      
      # add option to toggle data on and off
      addLayersControl(
        overlayGroups = c("flood risk", "school community area", "school point"),
        baseGroups = c("topographic map", "satellite imagery"),
        options = layersControlOptions(collapsed = TRUE))
    
  })

}