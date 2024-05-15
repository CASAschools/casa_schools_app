flood_map <- function(input) {
  
  # filter buffers based on school
  buffers_filtered <- reactive({
    school_filtered(hazards_buffer, input$district, input$school_flooding)
  })
  
  renderLeaflet({
    
    # filter school buffers for school name
    selected_school <- buffers_filtered()
    
    # crop to selected school
    #flooding_school <- crop(FEMA_reclass, selected_school)
    
    # create school point based on centroid of buffer
    selected_school_point <- selected_school %>% 
      st_centroid()
    
    # grab the flooding polgons that intersect with that school area
   # selected_flood <- FEMA_reclass[selected_school, ]
    
    #intersect flooding polygons so only the extent within school area is shown
    #selected_flood_intersected <- st_intersection(selected_school, selected_flood)
    selected_flood_intersected <- st_intersection(selected_school, FEMA_reclass)
    
    # overlay the school buffer and school point on the FEMA flood risk shapefile
    # plot it
    selected_flood_intersected <- st_transform(selected_flood_intersected, crs = 4326)
   # selected_flood <- st_transform(selected_flood, crs = 4326)
    selected_school <- st_transform(selected_school, crs = 4326)
    selected_school_point <- st_transform(selected_school_point, crs = 4326)
    
    
    # define color palette and labels for FEMA flood zone classification
    labels <- c("High", "Moderate to Low", "Undetermined")
    flood_colors <- colorFactor(c("#0C46EE", "#AEDBEA", "#8DB6CD"), levels = c("High", "Moderate to Low", "Undetermined"))
    flood_palette <- colorFactor(palette = flood_colors,
                                 domain = selected_flood_intersected$flood_risk)
    
    # leaflet map of flood risk potential
    leaflet() %>% 
      
      # add basemap
      addProviderTiles(providers$Esri.WorldTopoMap) %>% 
      
      # add cropped flood risk
      addPolygons(data = selected_flood_intersected, fillColor = c("#0C46EE", "#AEDBEA", "#8DB6CD"),  fillOpacity = .7, group = "Flood Risk") %>% 
      
      # add school buffer polygon
      addPolygons(data = selected_school, color = "darkgrey", fill = FALSE, 
                  weight = 2, group = "School Community Area") %>% 
      
      # add school point
      addCircleMarkers(data = selected_school_point, color = "black", stroke = FALSE, 
                       weight = 10, radius = 5, fillOpacity = 1,
                       group = "School Point") %>% 
      
      # add legend for flood risk with custom labels
      addLegend("bottomright", colors = c("#0C46EE", "#AEDBEA", "#8DB6CD"), labels = labels,
                title = "Flood Risk", opacity = 0.7)
    
  })
  
}