# ----------------------- Load libraries -------------------------------
## download packages if they're not already installed
# list of required packages
required_packages <- c(
  "shiny", "shinydashboard", "shinyWidgets", "shinycssloaders", "tidyverse",
  "leaflet", "leaflet.extras", "leaflet.minicharts", "sf", "countrycode",
  "plotly", "terra", "colorspace", "RColorBrewer", "gridExtra"
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


# make sure the full cdscode can be seen
options(scipen = 999)

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

# Calmatters Load In
calmatters <- read_csv("/capstone/casaschools/shiny_dashboard/data/calmatters/disasterDays.csv")

# Extreme Heat Import
extreme_heat <- read_csv("/capstone/casaschools/shiny_dashboard/data/extreme_heat/extreme_heat.csv") %>% 
  select(c(CDSCode, year, total, scenario))

extreme_heat1 <- extreme_heat %>%
  filter(CDSCode == 42767864231726)
#---------------------------- Precipitation ----------------------------
extreme_precip <- read_csv("/capstone/casaschools/shiny_dashboard/data/precipitation/test_precip_file.csv") 

extreme_precip1 <- extreme_precip %>% filter(CDSCode == 42767864231726)

# ----------------------- Hazard summary -------------------------------
# load in data
sb_hazards_test <- read_csv("/capstone/casaschools/hazard_summary/testing/sb_hazards_test.csv")

## hazard summary plot set up -----
# labels for each climate hazard
hazard_labels <- c("flooding", "extreme heat", "extreme precipitation", "coastal flooding", "wildfire")

# lollipop chart color palette
green_red <- divergingx_hcl(n = 5, palette = "RdYlGn", rev = TRUE)

# ----------------------- Wildfire -------------------------------
# load in data
whp_reclass <- rast("/capstone/casaschools/wildfire/intermediate_layers/whp_reclass.tif")

# define custom color palette and labels
# whp_palette <- c("white", "#fee391", "#fec44f", "#fe9929", "#d95f0e", "#993404")
# whp_labels <- c("non-burnable", "very low", "low", "moderate", "high", "very high")



