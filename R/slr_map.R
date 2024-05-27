slr_map <- function(input) {
  
  # filter school buffers based on welcome page district input and sea level rise tab school input
  buffers_filtered <- reactive({
    school_filtered(hazards_buffer, input$district, input$school_slr)
  })
  
  # render map
  renderLeaflet({
    
    # grab school buffer
    school_buffer <- buffers_filtered()
    
    # calculate the centroid of the school buffer
    school_point <- st_centroid(school_buffer)
    
    # change the CRS of the buffer and school point to WGS 1984 for mapping
    school_buffer <- st_transform(school_buffer, crs = 4326)
    school_point <- st_transform(school_point, crs = 4326)
    
    # select sea level rise polygons that intersect with the school buffer
    slr_intersect <- st_intersection(school_buffer, ca_slr)
    
    # plot the extent of sea level rise
    leaflet(options = leafletOptions(attributionControl = FALSE)) %>% 
      # add topo basemap
      addProviderTiles(providers$Esri.WorldTopoMap, group = "topographic map") %>%
      # add imagery basemap
      addProviderTiles(providers$Esri.WorldImagery, group = "satellite imagery") %>% 
      # add intersected sea level rise polygon
      addPolygons(data = slr_intersect, fillColor = "cornflowerblue",
                  fillOpacity = .8, stroke = FALSE, group = "school sea level rise extent") %>% 
      # add school buffer polygon
      addPolygons(data = school_buffer, color = "black", fill = FALSE,
                  weight = 2, group = "school community area") %>% 
      # add school point
      addCircleMarkers(data = school_point, color = "orange", stroke = FALSE,
                       weight = 2, radius = 5, fillOpacity = 1, group = "school point") %>% 
      # add legend for sea level rise
      addLegend("bottomright", colors = "cornflowerblue", labels = "Sea level rise extent",
                title = "", opacity = 1) %>%
      # add a scale bar
      addScaleBar(position =  "bottomleft",
                  options = scaleBarOptions(imperial = TRUE,
                                            metric = FALSE,
                                            maxWidth = 200)) %>% 
      # add option to toggle data on and off
      addLayersControl(
        overlayGroups = c("school sea level rise extent", 
                          "school community area", "school point"),
        baseGroups = c("topographic map", "satellite imagery"),
        options = layersControlOptions(collapsed = TRUE)) %>% 
      # set zoom to be the center of the school
      setView(lng = school_point$Longitude, lat = school_point$Latitude, zoom = 12)
    
  })
  
}