# school filtering function to get around schools in different districts sharing the same name
school_filtered <- function(schools, district, input_school) {
  # filter for the selected district first
  district_filter <- filter(schools, DistrictNa %in% c(district))
  # filter for the selected school within that district
  district_filter %>% 
    filter(SchoolName %in% c(input_school))
}