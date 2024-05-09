# ----------------------- Load libraries -------------------------------
## download packages if they're not already installed
# list of required packages
required_packages <- c(
  "shiny", "shinydashboard", "shinyWidgets", "shinycssloaders", "tidyverse",
  "leaflet", "leaflet.extras", "leaflet.minicharts", "sf", "countrycode",
  "plotly", "terra", "colorspace", "RColorBrewer", "tmap"
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


# make sure the full cdscode can be seen
options(scipen = 999)

# ----------------------- CA school points -------------------------------
#Load in data
school_points <-  st_read("/capstone/casaschools/schools_data/California_Schools_2022-23/California_Schools_2022-23.shp") %>% 
  # filter to active schools
  filter(Status == "Active")

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


# ------------------------Flooding ---------------------------------------
# Flooding-FEMA Import
# Read in FEMA data for entire state
FEMA_state <- st_read("/capstone/casaschools/flooding/NFHL_06_20240401/NFHL_06_20240401.gdb",
                      layer = "S_FLD_HAZ_AR",
                      quiet = TRUE)

# read in california schools data
schools <- st_read("/capstone/casaschools/schools_data/schools_buffer/",
                   quiet = TRUE)

FEMA_state <- st_transform(FEMA_state, crs = st_crs(schools))

# group smaller categories together and assign "High" or "Moderate to Low" risk to them
FEMA_reclass <- FEMA_state %>%
  mutate(flood_risk = ifelse(str_detect(FLD_ZONE, "A") | str_detect(FLD_ZONE, "V"), "high",
                             ifelse(str_detect(FLD_ZONE, "X"),"moderate to low",
                                    "undetermined")))

# make sure the crs are the same
FEMA_reclass <- st_transform(FEMA_reclass, st_crs(schools))

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

flood

# ----------------------- Hazard summary -------------------------------
# load in data
sb_hazards_test <- read_csv("/capstone/casaschools/hazard_summary/testing/sb_hazards_test.csv")

## hazard summary plot set up -----
# labels for each climate hazard
hazard_labels <- c("flooding", "extreme heat", "extreme precipitation", "coastal flooding", "wildfire")

# lollipop chart color palette
green_red <- divergingx_hcl(n = 5, palette = "RdYlGn", rev = TRUE)

#---------------------------- Precipitation ----------------------------
extreme_precip <- read_csv("/capstone/casaschools/shiny_dashboard/data/precipitation/test_precip_file.csv") 

extreme_precip1 <- extreme_precip %>% filter(CDSCode == 42767864231726)

# extreme_precip45 <- read_csv("/capstone/casaschools/shiny_dashboard/data/precipitation/precip_rcp45_2000_2064.csv")
 # extreme_precip85 <- read_csv("/capstone/casaschools/shiny_dashboard/data/precipitation/precip_rcp85_2006_2064.csv")
 # 
 # # Jrename columns
 # extreme_precip45 <-  extreme_precip45 %>% 
 #   rename(
 #     ...1 = CDSCode,
 #     CDSCode = year,
 #     year = total,
 #     total = lat,
 #     lat = geometry)
 #  
 # extreme_precip85 <-  extreme_precip85 %>% rename(
 #   CDSCode = ...1,
 #   year = CDSCode,
 #   total = year,
 #   lat = total,
 #   long = geometry
 # )
 # 
 # dos_pueblos <- extreme_precip45 %>% filter(CDSCode == 42767864231726)
 # 
 # 
 # 
 # dos_pueblos$scenario <- 'intermediate scenario'
 # 
 # dos_pueblos85 <-  extreme_precip85 %>% filter(CDSCode == 42767864231726)
 # 
 # dos_pueblos85$scenario <- 'business as usual'
 # 
 # dos_combined <- rbind(dos_pueblos, dos_pueblos85)
 
