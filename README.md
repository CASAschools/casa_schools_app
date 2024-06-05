# CASAschools

## California Schools Climate Hazard Dashboard

To help schools and communities understand their climate risks, we created an R Shiny Dashboard to visualize five climate hazards at a school district level. The dashboard allows users to select/type their city, school district, and school to view the past, present, and future risks of **Wildfire**, **Flooding**, **Sea Level Rise**, **Extreme Heat**, and **Extreme Precipitation**. A hazard summary provides an overview of which hazards might be more pertinent to each school. Local-level climate adaptation resources are provided alongside a User Guide to walk users through the dashboard. The dashboard serves as a resource that allows teachers and students to explore relevant climate change information and to inform lesson plans centered around climate change and the environment. The dashboard is also accessible to policymakers who can use the information provided to inform school-related climate policy.

To read more details about the creation of the dashboard, please view the "Summary of Solution Design" section of the CASAschools Technical Documentation: https://bren.ucsb.edu/projects/climate-hazards-data-integration-and-visualization-climate-adaptation-solutions

## Hazard Summary
This tab features our hazard summary metric which displays a summarized risk score for all five climate hazards. Each school receives a ranking for each hazard from 0-5, representing lower to higher risk. The total hazard summary score for each school buffer area is measured on a scale from 0-25, with lower values representing lower climate hazard risk and higher values representing higher climate hazard risk. The total score is the sum of individual scores for each climate hazard.

## Explore Your Hazards

This tab features our five interactive climate hazard visualizations:
- **Extreme Heat**
- **Extreme Precipitation**
- **Wildfire**
- **Flooding**
- **Sea Level Rise**

Users can click on each tab at the top of the webpage to explore the risks associated with each climate hazard relative to their location. Users will be able to input their address in a search bar to get the information most relevant to them.

### Climate Information

Under this tab, users will be given links to additional resources to protect themselves and their communities against climate hazards, as well as short write-ups that provide more information on how to engage their community to address climate change.

### Glossary

Definitions of terms used throughout the dashboard are explained in this tab.

### User Guide

This tab will include a written and video walk-through of the dashboard to inform users on how to navigate each page, and filter for their prefered school for each hazard.

### Packages and Software

These are the primary packages used to run the R Shiny dashboard. Please view the "session_info.txt" file for software information, package versions, and the full list of packages required. 

- shiny
- shinydashboard
- shinyWidgets
- shinycssloaders
- tidyverse
- leaflet
- leaflet.extras
- leaflet.minicharts
- sf
- countrycode
- plotly
- terra
- colorspace
- RColorBrewer
- gridExtra
- fontawesome
- dichromat

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
│   ├── slr_map_2000.R
│   ├── slr_map.R
│   ├── summary_home.R
│   ├── summary_score_tab.R
│   ├── summary_tab.R
│   ├── summary_title_home.R
│   ├── update_school_name.R
│   ├── wildfire_map2012.R
│   └── wildfire_map2023.R
├── README_data_archival.md
├── README.md
├── server.R
├── session_info.txt
├── shiny_dashboard.Rproj
├── text
│   ├── about_text.html
│   ├── about_text.md
│   ├── flooding.html
│   ├── flooding.md
│   ├── glossary.html
│   ├── glossary.md
│   ├── heat.md
│   ├── images
│   │   ├── CASAschools2.JPG
│   │   ├── climate_ed.jpeg
│   │   ├── school_change-01.png
│   │   ├── school_change.png
│   │   └── Schoolyard.jpg
│   ├── info.html
│   ├── info.md
│   ├── precipitation.md
│   ├── slr.html
│   ├── slr.md
│   ├── summary.md
│   ├── wildfire.html
│   └── wildfire.md
├── ui.R
└── www
    ├── CASAschools2.JPG
    ├── climate_ed.jpeg
    ├── flooding_tutorial.jpg
    ├── hazard_tutorial.jpg
    ├── heat_tutorial.jpg
    ├── precip_tutorial.png
    ├── school_change.png
    ├── Schoolyard.jpg
    ├── slr_tutorial.jpg
    └── wildfire_tutorial.jpg
```




