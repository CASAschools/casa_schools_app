# CASAschools

## California Schools Climate Hazard Dashboard

To help schools and communities understand their climate risks, we created an R Shiny Dashboard to visualize five climate hazards at a school district level. The dashboard allows users to select/type their city, school district, and school to view the past, present, and future risks of **Wildfire**, **Flooding**, **Sea Level Rise**, **Extreme Heat**, and **Extreme Precipitation**. A hazard summary provides an overview of which hazards might be more pertinent to each school. Local-level climate adaptation resources are provided alongside a User Guide to walk users through the dashboard. The dashboard serves as a resource that allows teachers and students to explore relevant climate change information and to inform lesson plans centered around climate change and the environment. The dashboard is also accessible to policymakers who can use the information provided to inform school-related climate policy.

To read more details about the creation of the dashboard, please view the "Summary of Solution Design" section of the CASAschools Technical Documentation: https://bren.ucsb.edu/projects/climate-hazards-data-integration-and-visualization-climate-adaptation-solutions 

To view the dashboard click on this link! https://shinyapps.bren.ucsb.edu/CASASchools/ 

## Dashboard 
![image](https://github.com/CASAschools/shiny_dashboard/assets/108312152/13ea1fd0-6ee5-4579-9b44-992a7487b2df)

The following sections are descriptions of the different tabs found in the dashboard.
### Hazard Summary
This tab features our hazard summary metric which displays a summarized risk score for all five climate hazards. Each school receives a ranking for each hazard from 0-5, representing lower to higher risk. The total hazard summary score for each school buffer area is measured on a scale from 0-25, with lower values representing lower climate hazard risk and higher values representing higher climate hazard risk. The total score is the sum of individual scores for each climate hazard.

### Explore Your Hazards

This tab features our five interactive climate hazard visualizations:
- **Extreme Heat**
- **Extreme Precipitation**
- **Wildfire**
- **Flooding**
- **Sea Level Rise**

Users can click on each tab at the top of the webpage to explore the risks associated with each climate hazard relative to their location. Users will be able to select schools in their school district to view how their school compares to neighboring schools.

### Climate Information

Under this tab, users will be given links to additional resources to protect themselves and their communities against climate hazards, as well as short write-ups that provide more information on how to engage their community to address climate change.

### Glossary

Definitions of terms used throughout the dashboard are explained in this tab.

### User Guide

This tab will include a written and video walk-through of the dashboard to inform users on how to navigate each page, and filter for their prefered school for each hazard.

## Packages and Software

These are the primary packages used to run the R Shiny dashboard. Please view the `session_info.txt` file for software information, package versions, and the full list of packages required. 

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

## Authors 
The authors of this dashboard are [Liane Chen](https://github.com/lchenhub), [Charlie Curtin](https://github.com/charliecurtin1), [Kristina Glass](https://github.com/kristinaglass), and [Hazel Vaquero](https://github.com/hazelvaq). For any comments or questions about this dashboard, please reach out to @cp-casaschools@bren.ucsb.edu

### License
This work is licensed under a [Creative Commons Zero v1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/deed.en).

## Folders/File Structure
This repository includes three folders: `R`, `text`, and `www`. Each folder includes a README.md file explaining the files in the folder. The `R` folder contains functions for plotting diagrams and the interactive elements of the dashboard. The `text` folder contains Markdown files of text included throughout the dashboard. While the `www` folder contains images used in the dashboard.

|Files|Description|
|------|------------|
| global.R | Datasets, packages, and global options needed to run the dashboard |
| server.R | Function of dashboard outputting plots in relation with the user inputs in dropdown values |
| ui.R | Dashboard structure and elements such as dropdown boxes and sidebar |
|session_info.txt| Collection of session information: R version and packages version|

```bash
├── global.R
├── LICENSE
├── R
│   ├── flood_map.R
│   ├── heat_plot.R
│   ├── precip_plot.R
│   ├── README.md
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
├── rsconnect
│   └── shinyapps.io
│       └── hazelvaq
│           └── shiny_dashboard.dcf
├── server.R
├── session_info.txt
├── shiny_dashboard.Rproj
├── testing_stuff_hazel.qmd
├── text
│   ├── about.html
│   ├── about.md
│   ├── flooding.html
│   ├── flooding.md
│   ├── glossary.html
│   ├── glossary.md
│   ├── heat.md
│   ├── images
│   │   ├── CASAschools2.JPG
│   │   ├── climate_ed.jpeg
│   │   ├── hazard_tutorial.jpg
│   │   ├── precip_tutorial.png
│   │   ├── school_change-01.png
│   │   ├── school_change.png
│   │   └── Schoolyard.jpg
│   ├── info.html
│   ├── info.md
│   ├── precipitation.html
│   ├── precipitation.md
│   ├── README.md
│   ├── slr.html
│   ├── slr.md
│   ├── summary.md
│   ├── welcome.html
│   ├── welcome.md
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
    ├── README.md
    ├── school_change.png
    ├── Schoolyard.jpg
    ├── slr_tutorial.jpg
    └── wildfire_tutorial.jpg
```

## Metadata
To find additional information of the data used in this repository head over to the metadata: https://doi.org/10.5061/dryad.1jwstqk3g 




