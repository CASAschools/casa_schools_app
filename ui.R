# -------- dashboard Header--------------------------
header <- dashboardHeader(
  
  title = "CASA Schools",
  titleWidth = 188
) #END dashboardHeader

# -------- dashboard Sidebar--------------------------
sidebar <- dashboardSidebar(
  # sidebarMenu ----
  sidebarMenu(
    menuItem(text = h4("Welcome"), tabName = "welcome", icon = icon("star")),
    menuItem(text = h4(HTML("Explore Your Hazards")), tabName = "hazards", icon = icon("school")),
    #menuItem(text = h4("Hazard Summary Metric"), tabName = "index", icon = icon("map")),
    menuItem(text = h4("Adaptation"), tabName = "adapt", icon = icon("person")),
    menuItem(text = h4("User guide"), tabName = "guide", icon = icon("users"))
    
  )#END sidebarMENU
  
  
)#END dashboard Sidebar


# -------- dashboard Body-----------------------------
body <- dashboardBody(
  
  
  # ---------- Welcome tab -----------------------------    
  tabItems(
    tabItem(tabName = "welcome",
            fluidPage(
              box(width = NULL,
                  title = h3(tags$strong("Welcome to the CASAschools Climate Hazards Dashboard!")),
                  includeMarkdown("text/about_text.md"),
                  h3(tags$strong("Getting Started")),
                  sidebarLayout(
                    sidebarPanel(
                      selectInput("city", "Choose a city:", choices = unique(school_points$City)),
                      uiOutput("districtMenu"),
                      uiOutput("schoolMenu")
                    ),
                    mainPanel(
                      leafletOutput("map")
              )
            )))
    ),
    

    
    # ---------- Hazards tab -----------------------------
    tabItem(tabName = "hazards",
            fluidPage(
              box(
                width = NULL,
                title = h2(tags$strong("Dos Pueblos Senior High")),
                tabsetPanel(
                  tabPanel(h4("Extreme Heat"),
                           # Load extreme heat script
                           source("hazards_tab/extreme_heat.R",
                                  # Remove TRUE output
                                  local = TRUE, 
                                  echo = FALSE, 
                                  print.eval = FALSE)[1]
                           
                           
                           ),#END Extreme Heat

                  tabPanel(h4("Extreme Precipitation"),
                           # Load extreme precipitation script
                           source("hazards_tab/extreme_precipitation.R", 
                                  local = TRUE,
                                  echo = FALSE,
                                  print.eval = FALSE)[1]
                           
                           
                           ),#END EXTREME PRECIPITATION
                  
                  tabPanel(h4("Wildfire"),
                           # Load wildfire script
                           source("hazards_tab/wildfire.R", 
                                  local = TRUE,
                                  echo = FALSE,
                                  print.eval = FALSE)[1]
                           
                           
                           ),#END WILDFIRE
                  
                  tabPanel(h4("Flooding"),
                           # Load flooding script
                           source("hazards_tab/flooding.R", 
                                  local = TRUE,
                                  echo = FALSE,
                                  print.eval = FALSE)[1]
                           
                           ),#END FLOODING
                  
                  tabPanel(h4("Coastal Inundation"),
                           # Load coastal inundation script
                           source("hazards_tab/coastal_inundation.R", 
                                  local = TRUE,
                                  echo = FALSE,
                                  print.eval = FALSE)[1]
                           
                           ),#END COASTAL INUNDATION
                  
                  tabPanel(h4("Hazard Summary"),
                           #load hazard summary script
                           source("hazards_tab/hazard_summary.R",
                                  local = TRUE,
                                  echo = FALSE,
                                  print.eval = FALSE)[1]
                           
                           )#END HAZARD SUMMARY
                
              )#END Tabset Panel
              
            )#END Box
    
    )# END Fluid Pages
    
    ),#END HAZARDS TAB
    
    
    # --------- Index tab --------------------------------   
    tabItem(tabName = "index",
            # Content for the index tab
            fluidPage(
              
              
              box(width = NULL,
                  title = h2(tags$strong("Dos Pueblos Senior High Hazards Summary Metric"))
              )
              
            )#END FLUIDPAGE
            
    ),#END INDEX
    
    
    # ------- Socioeconomic tab ---------------------
    tabItem(tabName = "adapt",
            fluidPage(
              box(width = NULL,
                  includeMarkdown("text/socio.md"),
              )
            )#END FLUIDPAGE
    ),#END SOCIOECONOMIC TAB
    # ------- User guide tab -----------------------
    tabItem(tabName = "guide",
    )#END USER GUIDE
    
  ),#END TABS CONTENT
  
)#END BODY

# -------- Combine all in dashboardPage----------------
dashboardPage(header, sidebar, body,skin = "yellow")
