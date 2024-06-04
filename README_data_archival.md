---
editor_options: 
  markdown: 
    wrap: 72
---

This README.txt file was generated on 2024-05-23 by Liane Chen, Charlie
Curtin, Kristina Glass, and Hazel Vaquero. It is associated with the
data archival on this project through Dryad. To view the data archival
and download datasets, please visit
<https://doi.org/10.5061/dryad.1jwstqk3g>.

Recommended citation:

Curtin, Charles; Glass, Kristina; Chen, Liane; Vaquero, Hazel
(Forthcoming 2024). Climate Hazards Data Integration and Visualization
for the Climate Adaptations Solutions Accelerator through
School-Community Hubs [Dataset]. Dryad.
<https://doi.org/10.5061/dryad.1jwstqk3g>

**GENERAL INFORMATION**

1\. Title of the Project: Climate Adaptation Solutions Accelerator
through School Community Hubs (alias CASAschools)

2\. Author Information

A. Principal Investigator Contact Information

Name: Liane Chen, Charlie Curtin, Kristina Glass, and Hazel Vaquero

Institution: University of California Santa Barbara, Bren School of
Environmental Science & Management

Address: Bren Hall, 2400 University of California, Santa Barbara, CA
93117 Email: [liane\@ucsb.edu](mailto:liane@ucsb.edu){.email},
[charlescurtin\@ucsb.edu](mailto:charlescurtin@ucsb.edu){.email},
[kristinaglass\@ucsb.edu](mailto:kristinaglass@ucsb.edu){.email},
[hazelvaquero\@ucsb.edu](mailto:hazelvaquero@ucsb.edu){.email}

B. Associate or Co-investigator Contact Information Name:

Dr. Simone Pulver

Institution: University of California Santa Barbara, Environmental
Studies Program

Address: 4001 Bren Hall, 2400 University of California, Santa Barbara,
CA 93117 Email: [pulver\@ucsb.edu](mailto:pulver@ucsb.edu){.email}

C. Alternate Contact Information

Name: Dr. Sarah Anderson

Institution: University of California Santa Barbara Bren School of
Environmental Science & Management

Address: 4510 Bren Hall, 2400 University of California, Santa Barbara,
CA 93117

Email:
[sanderson\@bren.ucsb.edu](mailto:sanderson@bren.ucsb.edu){.email}

D. Alternate Contact Information

Name: Dr. Danielle Harlow

Institution: University of California Santa Barbara The Gevirtz School

Address: Education 3129 Gevirtz Graduate School of Education, University
of California-Santa Barbara, CA 93106

Email:
[danielle.harlow\@ucsb.edu](mailto:danielle.harlow@ucsb.edu){.email}

3\. Date of data collection or obtaining

Hazards Data

-   FEMA Flood NFHL V3.2: 2024-03-13

-   Wildfire Hazard Potential for the United States (270-m) version 2023
    (4th Edition): 2024-04-12

-   Coastal Storm Modeling System: 2024-04-02

-   Cal-Adapt:

    -   Maximum Daily Temperature: 2024-03-13

    -   Maximum Daily Precipitation: 2024-03-13

California Department of Education School Boundaries Data

-   California Schools 2022-2023: 2024-03-05

-   California School District Area 2022-2023

-   CalMatters Disaster Days: 2024-04-1

4\. Geographic location of data collection:

California, CA:

-   Cal-Adapt

-   Coastal Storm Modeling

-   California Schools 2022-2023

-   California School District Areas

-   CalMatters Disaster Days

-   FEMA NFHL

National:

-   Wildfire Hazard Potential for the United States (270-m) version 2023
    (4th Edition):

5\. Information about funding sources that supported the collection of
the data:

**SHARING/ACCESS INFORMATION**

1\. Licenses/restrictions placed on the data:

Open Source:

-   FEMA Flood NFHL V3.2

-   Wildfire Hazard Potential for the United States (270-m) version 2023
    (4th Edition)

-   Coastal Storm Modeling System

-   Cal-Adapt:

    -   Maximum Daily Temperature

    -   Maximum Daily Precipitation

School Boundaries Data

-   California Schools 2022-2023

-   California School District Area 2022-2023

-   CalMatters Disaster Days

2\. Links to location of data:

-   FEMA Flood NFHL V3.2: <https://msc.fema.gov/portal/advanceSearch>

-   Wildfire Hazard Potential for the United States (270-m) version 2023
    (4th Edition):
    <https://www.fs.usda.gov/rds/archive/catalog/RDS-2015-0047-4>

-   Coastal Storm Modeling System:
    <https://ourcoastourfuture.org/hazard-map>

-   Cal-Adapt: <https://ucanr-igis.github.io/caladaptr>

    -   Maximum Daily Temperature

    -   Maximum Daily Precipitation

School Boundaries Data

-   California Schools 2022-2023:
    <https://gis.data.ca.gov/datasets/CDEGIS::california-schools-2022-23/about>

-   California School District Area 2022-2023:
    <https://gis.data.ca.gov/maps/CDEGIS::california-school-district-areas-2022-23/about>

-   CalMatters Disaster Days:
    <https://disasterdays.calmatters.org/california-school-closures>

6\. Recommended citation for the project:

Curtin, Charles; Glass, Kristina; Chen, Liane; Vaquero, Hazel
(Forthcoming 2024). Climate Hazards Data Integration and Visualization
for the Climate Adaptations Solutions Accelerator through
School-Community Hubs [Dataset]. Dryad.
<https://doi.org/10.5061/dryad.1jwstqk3g>

**DATA & FILE OVERVIEW**

1\. File List: relevant files contained in the CASAschools GitHub
organization: <https://github.com/CASAschools>

├── climate_hazards

│ ├── calmatters

│ │ └── calmatter_cleaning.qmd: *Cleaning Calmatters Disaster day .csv
to be displayed on dashboard*

│ ├── climate_hazard_summary

│ │ └── hazard_summary.qmd: *Normalizes variables on a scale from 0-5
for use in the hazard summary scoring, contains code to recreate the
hazard summary plot in the dashboard*

│ ├── extreme_heat

│ │ ├── extreme_heat_threshold.qmd: *Determine maximum daily temperature
98th percentile threshold*

│ │ ├── dashboard_prep.qmd: *Joined RCP4.5 & RCP8.5 and prepped the
dataframe for usage in daashboard*

│ │ ├── schools_extreme_heat_days_rcp45.qmd: *Extreme heat days
calculated for all 10,008 schools in a RCP 4.5 scenario*

│ │ └── schools_extreme_heat_days_rcp85.qmd: *Extreme heat days
calculated for all 10,008 schools in a RCP 8.5 scenario*

│ ├── flooding-FEMA

│ │ ├── FEMA_schools.qmd: *Joined high risk with schools to find
percentage of area*

│ │ └── flooding_mapping.qmd: *Binned risk categories into high,
moderate to low, and undetermined and plotted leaflet*

│ ├── precipitation

│ │ ├── caladapt_precip_r.qmd: *Determine maximum daily precipitation
98th percentile threshold*

│ │ ├── joining_data.qmd: *Joined RCP4.5 & RCP8.5 and prepped the
dataframe for usage in daashboard*

│ │ ├── schools_extreme_precip_days_rcp45.qmd: *Extreme precipitation
days calculated for all 10,008 schools in a RCP 4.5 scenario*

│ │ └── schools_extreme_precip_days_rcp85.qmd: *Extreme precipitation
days calculated for all 10,008 schools in a RCP 4.5 scenario*

│ ├── sea_level_rise

│ │ └── sea_level_rise.qmd: *cleans sea level rise data and prepares it
for use in the hazard summary score and mapping in the dashboard*

│ └── wildfire

│ ├── wildfire_mapping.qmd: *prepares wildfire data for mapping in the
dashboard*

│ └── wildfire_prep.qmd: *cleans wildfire data and prepares it for use
in the hazard summary score*

├── shiny_dashboard: *all of the code needed to run the California
Schools Climate Hazards Dashboard*

│ ├── global.R: *datasets, packages, and global options needed to run
the dashboard*

│ ├── R: *scripts that build plots, maps, and reactive text*

│ ├── server.R: *outputs plots, maps, and connects the buttons based on
user input*

│ ├── shiny_dashboard.Rproj

│ ├── text: *markdown files that contain the text for each page*

│ ├── ui.R: *layout elements and structure of the dashboard*

│ └── www: *any images used in the dashboard*

2\. Relationship between files, if important:

All of the repositories up to shiny_dashboard contain the code needed to
create final outputs for use in the California Schools Climate Hazards
Dashboard. The shiny_dashboard uses these datasets, which are included
as a part of this submission.

**METHODOLOGICAL INFORMATION**

1\. Description of methods used for collection/generation of data:

Data for extreme heat and extreme precipitation were retrieved using API
requests from the caladaptr package. The data retrieved to calculate
extreme heat days were historical observed daily maximum temperature for
1961-2005 and projected daily maximum temperature for 2006-2064. The
data retrieved to calculate extreme precipitation days were historical
observed daily precipitation totals for 1961-2005 and projected daily
precipitation totals for 2006-2064.

Data for wildfire, flooding, and sea level rise were downloaded directly
from their sources and stored in a remote server for use.

2\. Methods for processing the data:

All data were processed in R Studio using Quarto Docs. Tabular data for
extreme heat and precipitation first used the retrieved historical data
to calculate a threshold value to classify an extreme event. The
threshold was determined to be the 98th percentile value of observed
historical data for California. For extreme heat, this is 98°F. For
extreme precipitation, this is 0.73 inches. Then, projected daily values
exceeding these thresholds were assigned a 1, and those not exceeding
assigned a 0. The count of projected extreme days within each year from
2005-2064 was then assigned to each California public school.

Spatial data was mainly processed to serve mapping purposes in the
dashboard. The wildfire raster was clipped to the boundaries of
California and reclassified. The mean wildfire hazard potential score
for each school area was also derived and attached to each school. The
original FEMA flood polygons have many different classifications, which
were reclassified into three categories: high risk, moderate to low
risk, and undetermined risk. The percentage of each school area that
falls within a high risk flood zone was also attached to each school.
The sea level rise polygons simply describe the extent of flooding under
a 0.8 feet sea level rise scenario and a 100-year coastal storm. The
polygons were simplified to decrease map load times in the dashboard.
The percentage of each school area affected by the sea level rise
scenario and a 100-year coastal storm were also attached to each school.

To read a more detailed description of data processing, please refer to
the "Summary of Solution Design" section in the CASAschools Technical
Documentation:
<https://bren.ucsb.edu/projects/climate-hazards-data-integration-and-visualization-climate-adaptation-solutions>

3\. Instrument- or software-specific information needed to interpret the
data:

-   Software: R Studio version 2022.12.0.353.20

-   R version 4.2.2 (2022-10-31)

-   Packages used, versions, and source

         abind                1.4-5       2016-07-21 [2] CRAN (R 4.2.2)
         backports            1.4.1       2021-12-13 [2] CRAN (R 4.2.2)
         base64enc            0.1-3       2015-07-28 [2] CRAN (R 4.2.2)
         broom                1.0.5       2023-06-09 [2] CRAN (R 4.2.2)
         bslib                0.7.0       2024-03-29 [1] CRAN (R 4.2.2)
         cachem               1.0.8       2023-05-01 [2] CRAN (R 4.2.2)
         class                7.3-20      2022-01-16 [2] CRAN (R 4.2.2)
         classInt             0.4-10      2023-09-05 [2] CRAN (R 4.2.2)
         cli                  3.6.2       2023-12-11 [1] CRAN (R 4.2.2)
         cluster              2.1.4       2022-08-22 [2] CRAN (R 4.2.2)
         codetools            0.2-18      2020-11-04 [2] CRAN (R 4.2.2)
         colorspace         * 2.1-0       2023-01-23 [2] CRAN (R 4.2.2)
         countrycode        * 1.6.0       2024-03-22 [1] CRAN (R 4.2.2)
         crosstalk            1.2.1       2023-11-23 [1] CRAN (R 4.2.2)
         data.table           1.14.8      2023-02-17 [2] CRAN (R 4.2.2)
         DBI                  1.2.2       2024-02-16 [1] CRAN (R 4.2.2)
         DEoptimR             1.0-11      2022-04-03 [2] CRAN (R 4.2.2)
         devtools           * 2.4.5       2022-10-11 [2] CRAN (R 4.2.2)
         dichromat          * 2.0-0.1     2022-05-02 [2] CRAN (R 4.2.2)
         digest               0.6.35      2024-03-11 [1] CRAN (R 4.2.2)
         diptest              0.77-1      2024-04-10 [1] CRAN (R 4.2.2)
         dplyr              * 1.1.3       2023-09-03 [2] CRAN (R 4.2.2)
         e1071                1.7-14      2023-12-06 [1] CRAN (R 4.2.2)
         ellipsis             0.3.2       2021-04-29 [2] CRAN (R 4.2.2)
         fansi                1.0.6       2023-12-08 [1] CRAN (R 4.2.2)
         fastmap              1.1.1       2023-02-24 [2] CRAN (R 4.2.2)
         flexmix              2.3-19      2023-03-16 [1] CRAN (R 4.2.2)
         fontawesome        * 0.5.2       2023-08-19 [2] CRAN (R 4.2.2)
         forcats            * 1.0.0       2023-01-29 [2] CRAN (R 4.2.2)
         fpc                  2.2-12      2024-04-30 [1] CRAN (R 4.2.2)
         fs                   1.6.4       2024-04-25 [1] CRAN (R 4.2.2)
         generics             0.1.3       2022-07-05 [2] CRAN (R 4.2.2)
         ggplot2            * 3.5.0       2024-02-23 [1] CRAN (R 4.2.2)
         glue                 1.7.0       2024-01-09 [1] CRAN (R 4.2.2)
         gridExtra          * 2.3         2017-09-09 [2] CRAN (R 4.2.2)
         gtable               0.3.4       2023-08-21 [2] CRAN (R 4.2.2)
         hms                  1.1.3       2023-03-21 [2] CRAN (R 4.2.2)
         htmltools            0.5.8.1     2024-04-04 [1] CRAN (R 4.2.2)
         htmlwidgets          1.6.4       2023-12-06 [1] CRAN (R 4.2.2)
         httpuv               1.6.9       2023-02-14 [2] CRAN (R 4.2.2)
         httr                 1.4.5       2023-02-24 [2] CRAN (R 4.2.2)
         insight              0.19.11     2024-05-12 [1] CRAN (R 4.2.2)
         janitor            * 2.2.0       2023-02-02 [2] CRAN (R 4.2.2)
         jquerylib            0.1.4       2021-04-26 [2] CRAN (R 4.2.2)
         jsonlite             1.8.8       2023-12-04 [1] CRAN (R 4.2.2)
         kernlab              0.9-32      2023-01-31 [2] CRAN (R 4.2.2)
         KernSmooth           2.23-20     2021-05-03 [2] CRAN (R 4.2.2)
         knitr                1.46        2024-04-06 [1] CRAN (R 4.2.2)
         later                1.3.0       2021-08-18 [2] CRAN (R 4.2.2)
         lattice              0.20-45     2021-09-22 [2] CRAN (R 4.2.2)
         lazyeval             0.2.2       2019-03-15 [2] CRAN (R 4.2.2)
         leafem               0.2.3       2023-09-17 [2] CRAN (R 4.2.2)
         leaflet            * 2.2.2       2024-03-26 [1] CRAN (R 4.2.2)
         leaflet.extras     * 1.0.0       2018-04-21 [1] CRAN (R 4.2.2)
         leaflet.minicharts * 0.6.2       2021-05-11 [1] CRAN (R 4.2.2)
         leaflet.providers    2.0.0       2023-10-17 [2] CRAN (R 4.2.2)
         leafsync             0.1.0       2019-03-05 [2] CRAN (R 4.2.2)
         lifecycle            1.0.4       2023-11-07 [1] CRAN (R 4.2.2)
         lubridate          * 1.9.2       2023-02-10 [2] CRAN (R 4.2.2)
         lwgeom               0.2-13      2023-05-22 [2] CRAN (R 4.2.2)
         magrittr             2.0.3       2022-03-30 [2] CRAN (R 4.2.2)
         MASS                 7.3-58.1    2022-08-03 [2] CRAN (R 4.2.2)
         mclust               6.0.0       2022-10-31 [2] CRAN (R 4.2.2)
         memoise              2.0.1       2021-11-26 [2] CRAN (R 4.2.2)
         mime                 0.12        2021-09-28 [2] CRAN (R 4.2.2)
         miniUI               0.1.1.1     2018-05-18 [2] CRAN (R 4.2.2)
         modeltools           0.2-23      2020-03-05 [2] CRAN (R 4.2.2)
         moments              0.14.1      2022-05-02 [1] CRAN (R 4.2.2)
         munsell              0.5.1       2024-04-01 [1] CRAN (R 4.2.2)
         nnet                 7.3-18      2022-09-28 [2] CRAN (R 4.2.2)
         nullabor             0.3.9       2020-02-25 [1] CRAN (R 4.2.2)
         pillar               1.9.0       2023-03-22 [2] CRAN (R 4.2.2)
         pkgbuild             1.4.4       2024-03-17 [1] CRAN (R 4.2.2)
         pkgconfig            2.0.3       2019-09-22 [2] CRAN (R 4.2.2)
         pkgload              1.3.4       2024-01-16 [1] CRAN (R 4.2.2)
         plotly             * 4.10.4      2024-01-13 [1] CRAN (R 4.2.2)
         png                  0.1-8       2022-11-29 [2] CRAN (R 4.2.2)
         prabclus             2.3-3       2023-10-24 [1] CRAN (R 4.2.2)
         profvis              0.3.7       2020-11-02 [2] CRAN (R 4.2.2)
         promises             1.2.0.1     2021-02-11 [2] CRAN (R 4.2.2)
         proxy                0.4-27      2022-06-09 [2] CRAN (R 4.2.2)
         purrr              * 1.0.2       2023-08-10 [2] CRAN (R 4.2.2)
         R6                   2.5.1       2021-08-19 [2] CRAN (R 4.2.2)
         raster               3.6-26      2023-10-14 [2] CRAN (R 4.2.2)
         RColorBrewer       * 1.1-3       2022-04-03 [2] CRAN (R 4.2.2)
         Rcpp                 1.0.12      2024-01-09 [1] CRAN (R 4.2.2)
         readr              * 2.1.4       2023-02-10 [2] CRAN (R 4.2.2)
         regressinator      * 0.1.3       2024-01-11 [1] CRAN (R 4.2.2)
         remotes              2.4.2.1     2023-07-18 [2] CRAN (R 4.2.2)
         rlang                1.1.3       2024-01-10 [1] CRAN (R 4.2.2)
         rlist              * 0.4.6.2     2021-09-03 [1] CRAN (R 4.2.2)
         robustbase           0.95-0      2022-04-02 [2] CRAN (R 4.2.2)
         rstudioapi           0.15.0      2023-07-07 [2] CRAN (R 4.2.2)
         sass                 0.4.9       2024-03-15 [1] CRAN (R 4.2.2)
         scales               1.3.0       2023-11-28 [1] CRAN (R 4.2.2)
         sessioninfo          1.2.2       2021-12-06 [2] CRAN (R 4.2.2)
         sf                 * 1.0-14      2023-07-11 [2] CRAN (R 4.2.2)
         shiny              * 1.7.4       2022-12-15 [2] CRAN (R 4.2.2)
         shinycssloaders    * 1.0.0       2020-07-28 [1] CRAN (R 4.2.2)
         shinydashboard     * 0.7.2       2021-09-30 [1] CRAN (R 4.2.2)
         shinyWidgets       * 0.8.6       2024-04-24 [1] CRAN (R 4.2.2)
         snakecase            0.11.1      2023-08-27 [2] CRAN (R 4.2.2)
         sp                   2.1-4       2024-04-30 [1] CRAN (R 4.2.2)
         stars                0.6-4       2023-09-11 [2] CRAN (R 4.2.2)
         stringi              1.7.12      2023-01-11 [2] CRAN (R 4.2.2)
         stringr            * 1.5.0       2022-12-02 [2] CRAN (R 4.2.2)
         terra              * 1.7-55      2023-10-13 [2] CRAN (R 4.2.2)
         tibble             * 3.2.1       2023-03-20 [2] CRAN (R 4.2.2)
         tidyr              * 1.3.0       2023-01-24 [2] CRAN (R 4.2.2)
         tidyselect           1.2.1       2024-03-11 [1] CRAN (R 4.2.2)
         tidyverse          * 2.0.0       2023-02-22 [2] CRAN (R 4.2.2)
         timechange           0.2.0       2023-01-11 [2] CRAN (R 4.2.2)
         tmap               * 3.3-3       2024-05-06 [1] Github (mtennekes/tmap@a4e9fc9)
         tmaptools            3.1-1       2023-10-19 [2] Github (r-tmap/tmaptools@0c8b0b1)
         tzdb                 0.3.0       2022-03-28 [2] CRAN (R 4.2.2)
         units              * 0.8-5       2023-11-28 [1] CRAN (R 4.2.2)
         urlchecker           1.0.1       2021-11-30 [2] CRAN (R 4.2.2)
         usethis            * 2.1.6       2022-05-25 [2] CRAN (R 4.2.2)
         utf8                 1.2.4       2023-10-22 [1] CRAN (R 4.2.2)
         vctrs                0.6.5       2023-12-01 [1] CRAN (R 4.2.2)
         viridisLite          0.4.2       2023-05-02 [2] CRAN (R 4.2.2)
         withr                3.0.0       2024-01-16 [1] CRAN (R 4.2.2)
         xfun                 0.43        2024-03-25 [1] CRAN (R 4.2.2)
         XML                  3.99-0.16.1 2024-01-22 [1] CRAN (R 4.2.2)
         xtable               1.8-4       2019-04-21 [2] CRAN (R 4.2.2)
         zoo                * 1.8-12      2023-04-13 [2] CRAN (R 4.2.2)

**DATA-SPECIFIC INFORMATION FOR:**

These are the datasets associated with this submission. They are the
tables and spatial data needed for the California Schools Climate
Hazards Dashboard.

1.  extreme_heat.csv: *contains the total number of projected extreme
    heat days for every California public school between 2006-2064*

    1.  number of variables: 7

    2.  number of cases/rows: 1180944

    3.  relevant variables:

        1.  CDSCode: *unique school identifier*

        2.  year: *year from 2006-2064*

        3.  total: *total number of extreme heat days in a given year
            for a given RCP scenario*

        4.  scenario: *Representative Concentration Pathway (RCP),
            either 4.5 or 8.5*

        5.  DistrictNa: *school district*

        6.  SchoolName: *school name*

    4.  missing data code: NA

2.  extreme_precipitation.csv: *contains the total number of projected
    extreme precipitation days for every California public school
    between 2006-2064*

    1.  number of variables: 9

    2.  number of cases/rows: 1180944

    3.  relevant variables:

        1.  CDSCode: *unique school identifier*

        2.  year: *year from 2006-2064*

        3.  total: *total number of extreme precipitation days in a
            given year for a given RCP scenario*

        4.  scenario: *Representative Concentration Pathway (RCP),
            either 4.5 or 8.5*

        5.  City: *city that the school is in*

        6.  DistrictNa: *school district*

        7.  SchoolName: *school name*

    4.  missing data code: NA

3.  schools_hazards_intervals.csv: *contains a single number summary of
    each hazard for each school, the normalized score from 0-5 of each
    hazard for each school, and the total score*

    1.  number of variables: 13

    2.  number of cases/rows: 10008

    3.  relevant variables:

        1.  CDSCode: *unique school identifier*

        2.  SchoolName: *school name*

        3.  DistrictNa: *school district*

        4.  slr_percent: *percentage of school area affected by sea
            level rise and a 100-year coastal storm*

        5.  FEMA_percent: *percentage of school area within a high risk
            flood zone*

        6.  schools_heat: *total number of extreme heat days between
            2025-2030*

        7.  schools_precip: *total number of extreme precipitation days
            between 2025-2030*

        8.  whp: *mean wildfire hazard potential score from 0-5*

        9.  flood_score: *FEMA_percent normalized from 0-5*

        10. slr_score: *slr_percent normalized from 0-5*

        11. heat_score: *schools_heat normalized from 0-5*

        12. precip_score: *schools_precip normalized from 0-5*

        13. hazard_score: *the total hazard score, or the sum of whp,
            flood_score, slr_score, heat_score, and precip_score*

    4.  missing data code: NA

4.  ca_slr_simple.shp: *simplified polygons describing flooding extent
    under 0.8 feet of sea level rise (projected 2050 sea levels) and a
    100-year coastal storm for California*

    1.  number of variables: 2

    2.  number of features: 82

    3.  variable list: FID, geometry

    4.  missing data code: NA

    5.  coordinate reference system: EPSG 4326

5.  ca_slr_2000_simple.shp: *simplified polygons describing flooding
    extent with no sea level rise (2000 sea levels) and a 100-year
    coastal storm for California*

    1.  number of variables: 2

    2.  number of features: 95

    3.  variable list: FID, geometry

    4.  missing data code: NA

    5.  coordinate reference system: EPSG 4326

6.  whp_reclass2012.tif: *a raster of wildfire hazard potential for
    California from 2012 reclassified to very low, low, moderate, high,
    and very high*

    1.  raster file format: GeoTIFF

    2.  raster dimensions: 3871 rows, 3334 columns

    3.  spatial resolution: 270 meters

    4.  coordinate reference system: EPSG 3857

    5.  missing data code: NA

7.  whp_reclass.tif: *a raster of wildfire hazard potential for
    California from 2023 reclassified to very low, low, moderate, high,
    and very high*

    1.  raster file format: GeoTIFF

    2.  raster dimensions: 3871 rows, 3334 columns

    3.  spatial resolution: 270 meters

    4.  coordinate reference system: EPSG 3857

    5.  missing data code: NA

8.  fema_reclass_simple.shp: *simplified polygons describing flood risk
    for California reclassified to high risk, moderate to low risk, and
    undetermined risk*

    1.  number of variables: 24

    2.  number of features: 57136

    3.  variable list: DFIRM_I, VERSION, FLD_AR\_, STUDY_T, FLD_ZON,
        ZONE_SU, SFHA_TF, STATIC\_, V_DATUM, DEPTH, LEN_UNI, VELOCIT,
        VEL_UNI, AR_REVE, AR_SUBT, BFE_REV, DEP_REV, DUAL_ZO, SOURCE\_,
        GFID, SHAPE_L, SHAPE_A, fld_risk, geometry

    4.  missing data codes: NA

    5.  coordinate reference system: EPSG 4269
