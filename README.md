# CASAschools

## R Shiny Dashboard

To help schools and communities understand their climate risks, we will create an R Shiny Dashboard to visualize five climate hazards at a school district level. The dashboard will allow users to input an address to view the past, present, and future risks of **Wildfire**, **Flooding**, **Sea Level Rise**, **Extreme Heat**, and **Extreme Precipitation** as well as be given a score to determine their overall risk. Local-level climate adaptation resources will be provided alongside a User Guide to walk users through the dashboard. The dashboard will serve as a resource that allows teachers and students to explore relevant climate change information and to inform lesson plans centered around climate change and the environment. We intend for the dashboard to be accessible to policymakers as well who can use the information provided to inform school-related climate policy.

## Table of Contents
- [Usage](https://github.com/CASAschools/shiny_dashboard/blob/main/README.md#usage)
- [Libraries and Packages](https://github.com/CASAschools/shiny_dashboard/blob/main/README.md#libraries-and-packages)
- [Authors](https://github.com/CASAschools/shiny_dashboard/blob/main/README.md#authors)
- [License](https://github.com/CASAschools/shiny_dashboard/blob/main/README.md#license)

## Dashboard Tabs
![image](https://github.com/CASAschools/shiny_dashboard/assets/108312152/eefc6922-0032-409b-a1bc-2120f14faa90)
![image](https://github.com/CASAschools/shiny_dashboard/assets/108312152/eefc6922-0032-409b-a1bc-2120f14faa90)


### Hazard Summary Metric

This tab features our hazard summary metric which displays a summarized risk score for all five climate hazards. The hazard summary score for each school buffer area is measured on a scale from 0-25, with lower values representing lower climate hazard risk and higher values representing higher climate hazard risk. The composite score is the sum of individual scores for each climate hazard.

### Explore Your Hazards

This tab features our five interactive climate hazard visualizations:
- **Extreme Heat**
- **Extreme Precipitation**
- **Wildfire**
- **Flooding**
- **Sea-level Rise**

Users can click on each tab at the top of the webpage to explore the risks associated with each climate hazard relative to their location. Users will be able to input their address in a search bar to get the information most relevant to them.

### Climate Information

Under this tab, users will be given links to additional resources to protect themselves and their communities against climate hazards, as well as short write-ups that provide more information on how to engage their community to address climate change.

### User Guide

This tab will include a written and video walk-through of the dashboard to inform users on how to navigate each page, and filter for their prefered school for each hazard.
### Libraries and Packages
| tidyverse | sf | terra | dplyer | 
| -----|----- | -----|------|
| spData | spDataLarge | ggplot | tmap |
| RColorBrewer | caladaptr | shiny | shinydashboard |
| shinyWidgets | shinycssloaders | leaflet | leaflet.extras |
| leaflet.minicharts | countrycode | plotly | terra |
| colorspace | gridExtra | zoo | janitor |
| devtools | lubridate | rlist | tidyr |

### Authors 
The authors of this dashboard are [Liane Chen](https://github.com/lchenhub), [Charlie Curtin](https://github.com/charliecurtin1), [Kristina Glass](https://github.com/kristinaglass), and [Hazel Vaquero](https://github.com/hazelvaq). For any comments or questions about this dashboard, please reach out to @cp-casaschools@bren.ucsb.edu

### License
This work is licensed under a [Creative Commons Zero v1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/deed.en).

## File Structure


```bash
├── global.R
├── LICENSE
├── R
│   ├── flood_map.R
│   ├── heat_plot.R
│   ├── precip_plot.R
│   ├── school_filtered.R
│   ├── slr_map.R
│   ├── summary_home.R
│   ├── summary_score_home.R
│   ├── summary_score_tab.R
│   ├── summary_tab.R
│   ├── update_school_name.R
│   ├── wildfire_map2012.R
│   └── wildfire_map2023.R
├── README.md
├── server.R
├── shiny_dashboard.Rproj
├── text
│   ├── about_text.html
│   ├── about_text.md
│   ├── coastal_inundation.md
│   ├── flooding.md
│   ├── glossary.md
│   ├── heat.md
│   ├── precipitation.md
│   ├── socio.html
│   ├── socio.md
│   ├── summary.md
│   └── wildfire.md
└── ui.R
```




