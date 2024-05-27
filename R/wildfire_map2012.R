wildfire_map2012 <- function(input) {
  
  # filter school buffers based on welcome page district input and wildfire tab school input
  buffers_filtered <- reactive({
    school_filtered(hazards_buffer, input$district, input$school_wildfire)
  })
  
  # render wildfire map based on the chosen school
  renderLeaflet({
    
    # grab school buffer
    school_buffer <- buffers_filtered()
    
    # calculate the centroid of the school buffer and transform CRS to WGS 1984
    school_point <- st_centroid(school_buffer)
    
    # select the wildfire hazard potential cells that overlap
    whp_school2012 <- crop(whp_reclass2012, school_buffer)
    
    # change the CRS of the buffer and school point to WGS 1984 for mapping
    school_buffer <- st_transform(school_buffer, crs = 4326)
    school_point <- st_transform(school_point, crs = 4326)
    
    # Define color palette and labels for wildfire hazard potential
    labels <- c("Developed or open water", "Very low", "Low", "Moderate", "High", "Very high", "")
    whp_colors <- c("grey", "#fee391", "#fec44f", "#fe9929", "#d95f0e", "#993404", "transparent")
    whp_palette <- colorFactor(palette = whp_colors,
                               domain = values(whp_school2012),
                               na.color = "transparent")
    
    # create wildfire map
    leaflet(options = leafletOptions(attributionControl = FALSE)) %>%
      # add topo basemap
      addProviderTiles(providers$Esri.WorldTopoMap, group = "topographic map") %>%
      # add imagery basemap
      addProviderTiles(providers$Esri.WorldImagery, group = "satellite imagery") %>% 
      # add cropped whp raster for 2023
      addRasterImage(whp_school2012, colors = whp_palette,
                     opacity = .7, group = "wildfire hazard") %>%
      # add school buffer polygon
      addPolygons(data = school_buffer, color = "black", fill = FALSE,
                  weight = 2, group = "school community area") %>%
      # add school point
      addCircleMarkers(data = school_point, color = "blue", stroke = FALSE,
                       weight = 3, radius = 5, fillOpacity = 1, group = "school point") %>%
      # add a scale bar
      addScaleBar(position =  "bottomleft",
                  options = scaleBarOptions(imperial = TRUE,
                                            metric = FALSE,
                                            maxWidth = 200)) %>% 
      # add option to toggle data on and off
      addLayersControl(
        overlayGroups = c("wildfire hazard", "school community area", "school point"),
        baseGroups = c("topographic map", "satellite imagery"),
        options = layersControlOptions(collapsed = TRUE))
    
  })
  
}