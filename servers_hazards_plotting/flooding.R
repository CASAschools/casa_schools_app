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