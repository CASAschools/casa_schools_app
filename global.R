# ----------------------- Load libraries -------------------------------
## download packages if they're not already installed
# list of required packages
required_packages <- c(
  "shiny", "shinydashboard", "shinyWidgets", "shinycssloaders", "tidyverse",
  "leaflet", "leaflet.extras", "leaflet.minicharts", "sf", "countrycode",
  "plotly", "terra", "colorspace", "RColorBrewer", "gridExtra", "fontawesome"
)

# install missing packages
install_missing <- function(package) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package)
    library(package, character.only = TRUE)
  }
}

# apply function to list of required packages
sapply(required_packages, install_missing)


# Load libraries
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(leaflet.minicharts)
library(sf)
library(countrycode) 
library(plotly)
library(terra)
library(colorspace)
library(RColorBrewer)
library(gridExtra)
library(fontawesome)


# make sure the full cdscode can be seen
options(scipen = 999)
options(warn = -1)
# ----------------------- CA school points -------------------------------
#Load in data
school_points <-  st_read("/capstone/casaschools/schools_data/California_Schools_2022-23/California_Schools_2022-23.shp") %>% 
  # filter to active schools
  filter(Status == "Active")

# read in full school buffers
schools_buffers <- st_read("/capstone/casaschools/schools_data/schools_buffer/schools_points_buffer.shp",
                           quiet = TRUE)

# Transform CRS
school_points <- st_transform(school_points, crs = "EPSG:4326" )

#only filter for Active schools

school_points <- school_points %>% filter(Status == "Active")

school_points <- school_points %>% mutate(MarkerString = paste(
  SchoolName,", School Type: ",
  SchoolType,", Street Address: ",
  Street,", Enrollment Total: ",
  EnrollTota,", % of African American Students: ",
  AApct,", % of American Indian Students: ",
  AIpct, ", % of Asian Students: ",
  ASpct,", % of Filipino Students: ",
  FIpct, ", % of Hispanic Students: ",
  HIpct, ", % of Pacific Islander Students: ",
  PIpct, ", % of White Students: ",
  WHpct, ", % of Multi-Racial Students: ",
  MRpct, ", % of English Learners: ",
  ELpct, ", % of Socioeconimically Disadvantaged Students: ",
  SEDpct, ", School Locale: ",
  Locale))

# Drop geometry
school_points_rm <- school_points %>% st_drop_geometry()

school_names <- school_points_rm %>% select("CDSCode", "DistrictNa","SchoolName")

# Calmatters Load In
calmatters <- read_csv("/capstone/casaschools/shiny_dashboard/data/calmatters/disasterDays.csv")

# -------------------- EXTREME HEAT --------------------------------------
# Extreme Heat Import
extreme_heat <- read.csv("/capstone/casaschools/shiny_dashboard/data/extreme_heat/extreme_heat.csv") 

#---------------------------- Precipitation ----------------------------
extreme_precip <- read_csv("/capstone/casaschools/shiny_dashboard/data/precipitation/extreme_precipitation.csv") 

# ----------------------- Hazard summary -------------------------------

# load in data
hazards_test <- read_csv("/capstone/casaschools/hazard_summary/testing/schools_hazards_intervals.csv")

## hazard summary plot set up -----
# labels for each climate hazard
hazard_labels <- c("flooding", "extreme heat", "extreme\nprecipitation", "sea level rise", "wildfire")

# custom color palette
custom_pal <- c("#FFCF73", "#F2EAAB", "#8FD2E3", "#6B9EB8", "#5A5E9E")

# ----------------------- Wildfire -------------------------------

# load in data
whp_reclass <- rast("/capstone/casaschools/wildfire/intermediate_layers/whp_reclass.tif")

whp_reclass2012 <- rast("/capstone/casaschools/wildfire/intermediate_layers/whp_reclass2012.tif")

# --------------------Sea Level Rise-----------------------------

# load in data
ca_slr <- st_read("/capstone/casaschools/sea_level_rise/intermediate_layers/ca_slr.shp")


# ----------------------- Flooding -------------------------------
# load in data
FEMA_reclass <- st_read("/capstone/casaschools/flooding/intermediate_layers/fema_high_union.shp")

# make sure the crs are the same (WGS 84)
FEMA_reclass <- st_transform(FEMA_reclass, st_crs(schools_buffers))

#clip school buffers to flood intersections
#FEMA_schools <- st_intersection(school_buffers, FEMA_reclass)

# ----------------------------------------------------------------

school_names <- school_points_rm %>% select("CDSCode", "DistrictNa","SchoolName")

# names_precip_merge <- merge(extreme_precip, school_names, by = "CDSCode")

# add cities to hazards test
hazards_buffer <- schools_buffers %>% left_join(hazards_test)

#buffer color
pal <- colorNumeric(c("#5A5E9E", "#6B9EB8", "#8FD2E3", "#F2EAAB", "#FFCF73"), hazards_buffer$hazard_score, reverse = TRUE)

#Add marker string to hazards data framework

hazards_buffer <- hazards_buffer %>% 
  mutate(HazardString = paste(SchoolName, "has a Hazard Score of: ", hazard_score))

 markers <- makeAwesomeIcon(
    icon="empty",
     markerColor = "lightblue",
     library="fa"
   )
 
 icons <- makeIcon(
     iconUrl = "https://www.svgrepo.com/download/533533/school-flag.svg",
     iconWidth = 31*215/230,
     iconHeight = 20, 
     iconAnchorY = 33,
     iconAnchorX = 31*215/230/2
   )
 
  HazardString = paste(SchoolName, "has a Hazard Score of: ", hazard_score))
