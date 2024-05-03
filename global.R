# ----------------------- Load libraries -------------------------------
## download packages if they're not already installed
# list of required packages
required_packages <- c(
  "shiny", "shinydashboard", "shinyWidgets", "shinycssloaders",
  "palmerpenguins", "tidyverse", "dplyr", "leaflet", 
  "leaflet.extras", "leaflet.minicharts", "sf", "countrycode",
  "plotly", "terra", "colorspace"
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
library(palmerpenguins)
library(tidyverse)
library(dplyr)
library(leaflet)
library(leaflet.extras)
library(leaflet.minicharts)
library(sf)
library(countrycode) 
library(plotly)
library(terra)
library(colorspace)
library(ggvis)


# make sure the full cdscode can be seen
options(scipen = 999)

# ----------------------- CA school points -------------------------------
#Load in data
school_points <-  st_read("/capstone/casaschools/schools_data/California_Schools_2022-23/California_Schools_2022-23.shp") %>% 
  # filter to active schools
  filter(Status == "Active")

# Transform CRS
school_points <- st_transform(school_points, crs = "EPSG:4326" )
# Drop geometry
school_points_rm <- school_points %>% st_drop_geometry()

# Calmatters Load In
calmatters <- read_csv("/capstone/casaschools/shiny_dashboard/data/calmatters/disasterDays.csv")

# Extreme Heat Import
extreme_heat <- read_csv("/capstone/casaschools/shiny_dashboard/data/extreme_heat/extreme_heat.csv") %>% 
  select(c(CDSCode, year, total, scenario))

extreme_heat1 <- extreme_heat %>%
  filter(CDSCode == 42767864231726)

# ----------------------- Hazard summary -------------------------------
# load in data
sb_hazards_test <- read_csv("/capstone/casaschools/hazard_summary/testing/sb_hazards_test.csv")

## hazard summary plot set up -----
# labels for each climate hazard
hazard_labels <- c("flooding", "extreme heat", "extreme precipitation", "coastal flooding", "wildfire")

# lollipop chart color palette
green_red <- divergingx_hcl(n = 5, palette = "RdYlGn", rev = TRUE)

