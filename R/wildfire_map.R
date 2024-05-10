# Define the function that will create and return the Leaflet map object
wildfire_map <- function(buffers_filtered) {
  
  # transform filtered buffer CRS to WGS 1984
  school_buffer <- buffers_filtered
  
  # calculate the centroid of the school buffer and transform CRS to WGS 1984
  school_point <- st_centroid(school_buffer)
  
  # select the wildfire hazard potential cells that overlap
  whp_school <- crop(whp_reclass, school_buffer)
  
  # change the CRS of the buffer and school point to WGS 1984 for mapping
  school_buffer <- st_transform(school_buffer, crs = 4326)
  school_point <- st_transform(school_point, crs = 4326)
  
  # Define color palette and labels for wildfire hazard potential
  labels <- c("non-burnable", "very low", "low", "moderate", "high", "very high", "")
  whp_colors <- c("white", "#fee391", "#fec44f", "#fe9929", "#d95f0e", "#993404", "transparent")
  whp_palette <- colorFactor(palette = whp_colors,
                             domain = values(whp_school),  # This will be updated after reading data
                             na.color = "transparent")
  
  
  
  # create wildfire map
  leaflet() %>% 
    addProviderTiles(providers$Esri.WorldTopoMap) %>% 
    addRasterImage(whp_school, colors = whp_palette, 
                   opacity = .7, group = "wildfire hazard potential") %>% 
    addPolygons(data = school_buffer, color = "black", fill = FALSE, 
                weight = 2, group = "school community area") %>% 
    addCircleMarkers(data = school_point, color = "blue", stroke = FALSE, 
                     weight = 3, radius = 5, fillOpacity = 1, group = "school point") %>% 
    addLegend("bottomright", colors = whp_colors, labels = labels, 
              title = "wildfire hazard potential", opacity = 0.5)
  
  
}
