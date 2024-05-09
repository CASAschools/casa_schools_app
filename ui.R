# -------- dashboard Header--------------------------
header <- dashboardHeader(
  
  title = "CASA Schools",
  titleWidth = 188
) #END dashboardHeader

# -------- dashboard Sidebar--------------------------
sidebar <- dashboardSidebar(width = 300,
  # sidebarMenu ----
  sidebarMenu(
    menuItem(text = h4("Welcome"), tabName = "welcome", icon = icon("star")),
    menuItem(text = h4("Hazard Summary Metric"), tabName = "index", icon = icon("square-poll-horizontal")),
    menuItem(text = h4("Explore Your Hazards"), tabName = "hazards", icon = icon("earth-americas"),
      # Explore Your Hazards Sub tabs
      menuSubItem(text = h4("Extreme Heat"), tabName = "heat", icon = icon("temperature-arrow-up")),
      menuSubItem(text = h4("Wildfire"), tabName = "wildfire", icon = icon("fire")),
      menuSubItem(text = h4("Extreme Precipitation"), tabName = "precipitation", icon = icon("cloud-showers-heavy")),
      menuSubItem(text = h4("Flooding"), tabName = "flooding", icon = icon("house-flood-water")),
      menuSubItem(text = h4("Sea Level Rise"), tabName = "sea_rise", icon = icon("house-tsunami"))
    ),
    menuItem(text = h4("Climate Information"), tabName = "info", icon = icon("circle-info")),
    menuItem(text = h4("Glossary"), tabName = "glossary", icon = icon("book-open")),
    menuItem(text = h4("User Guide"), tabName = "user", icon = icon("users"))

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
                      uiOutput("cityMenu"),
                      uiOutput("districtMenu"),
                      uiOutput("schoolMenu")
                    ),
                    mainPanel(
                      leafletOutput("map")
              )
            )))
    ),
    

    # --------- Hazard Summary Metric tab --------------------------------   
    tabItem(tabName = "index",
            # Content for the index tab
            fluidPage(

              box(width = NULL,
                  title = h2(tags$strong("Dos Pueblos Senior High Hazards Summary Metric"))
              )
              
            )#END FLUIDPAGE
            
    ),#END INDEX
    
    
    # ---------- Explore Your Hazards Sub Tabs -----------------------------
    
    # --------- Extreme Heat Tab -------------------------------------------   
    
    tabItem(tabName = "heat",
            fluidPage(
              box(
                width = NULL,
                "fire"
              )#END BOX
              
            )#END FluidPage
      
            ),#END HEAT TAB
    
    # --------- Wildfire Tab -----------------------------------------------
    tabItem(tabName = "wildfire",
            fluidPage(
              box(
                width = NULL,
                "wildfire"
              )# END BOX
              
            )#END FluidPage
            
            ),#END Wildfire
    
  
    # --------- Precipitation Tab ------------------------------------------
    
    tabItem(tabName = "precipitation",
            fluidPage(
              box(
                width = NULL,
                "precip"
              )#END BOX
              
            )#END FluidPage
            
    ),#END Flooding
    
    # --------- Flooding Tab------------------------------------
    
    tabItem(tabName = "flooding",
            fluidPage(
              box(
                width = NULL,
                "FLOODING"
              )#END BOX
              
            )#END FluidPage
            
            ),#END Flooding
    
    # --------- Sea Level Rise Tab ------------------------------------------
    
    tabItem(tabName = "sea_rise",
            fluidPage(
              box(
                width = NULL,
                "sea level"
              )#END BOX
              
            )#END FluidPage
            
    ),#END Sea Level Rise
    
    
    # tabItem(tabName = "hazards",
    #         fluidPage(
    #           box(
    #             width = NULL,
    #             title = h2(tags$strong("Dos Pueblos Senior High")),
    #             tabsetPanel(
    #               tabPanel(h4("Extreme Heat"),
    #                        # Load extreme heat script
    #                        source("hazards_tab/extreme_heat.R",
    #                               # Remove TRUE output
    #                               local = TRUE, 
    #                               echo = FALSE, 
    #                               print.eval = FALSE)[1]
    #                        
    #                        
    #                        ),#END Extreme Heat
    # 
    #               tabPanel(h4("Extreme Precipitation"),
    #                        # Load extreme precipitation script
    #                        source("hazards_tab/extreme_precipitation.R", 
    #                               local = TRUE,
    #                               echo = FALSE,
    #                               print.eval = FALSE)[1]
    #                        
    #                        
    #                        ),#END EXTREME PRECIPITATION
    #               
    #               tabPanel(h4("Wildfire"),
    #                        # Load wildfire script
    #                        source("hazards_tab/wildfire.R", 
    #                               local = TRUE,
    #                               echo = FALSE,
    #                               print.eval = FALSE)[1]
    #                        
    #                        
    #                        ),#END WILDFIRE
    #               
    #               tabPanel(h4("Flooding"),
    #                        # Load flooding script
    #                        source("hazards_tab/flooding.R", 
    #                               local = TRUE,
    #                               echo = FALSE,
    #                               print.eval = FALSE)[1]
    #                        
    #                        ),#END FLOODING
    #               
    #               tabPanel(h4("Coastal Inundation"),
    #                        # Load coastal inundation script
    #                        source("hazards_tab/coastal_inundation.R", 
    #                               local = TRUE,
    #                               echo = FALSE,
    #                               print.eval = FALSE)[1]
    #                        
    #                        ),#END COASTAL INUNDATION
    #               
    #               tabPanel(h4("Hazard Summary"),
    #                        #load hazard summary script
    #                        source("hazards_tab/hazard_summary.R",
    #                               local = TRUE,
    #                               echo = FALSE,
    #                               print.eval = FALSE)[1]
    #                        
    #                        )#END HAZARD SUMMARY
                
    #           )#END Tabset Panel
    #           
    #         )#END Box
    # 
    # )# END Fluid Pages
    # 
    # ),#END HAZARDS TAB
    
    
    # ------- Climate Information tab -----------------------------------
    # this will describe time concepts, how, why, etc...
    
    tabItem(tabName = "info",
            fluidPage(
              box(width = NULL,
                  includeMarkdown("text/socio.md"),
              )
            )#END FLUIDPAGE
    ),#END Climate Info TAB
    
    
    # ------- Glossary tab ---------------------------------------------
    tabItem(tabName = "glossary",
            fluidPage(
              box(width = NULL
                  
              )# END Box
              
            )# END FluidPage
            
            
    ),#END Glossary
    
    
    

    # ------- User guide tab -----------------------
    tabItem(tabName = "user",
            fluidPage(
              box(width = NULL
                  
                  )# END Box
              
            )# END FluidPage
            
            
    )#END USER GUIDE
    
  )#END TABS CONTENT
  
)#END BODY

# -------- Combine all in dashboardPage----------------
dashboardPage(header, sidebar, body,skin = "yellow")
