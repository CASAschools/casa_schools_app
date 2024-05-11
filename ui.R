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
                  style = "height: 800px",
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
                  style = "height: 800px",
                  title = h2(tags$strong("Dos Pueblos Senior High Hazards Summary Metric"))
              )
              
            )#END FLUIDPAGE
            
    ),#END INDEX
    
    
    # ---------- Explore Your Hazards Sub Tabs -----------------------------
    
    # --------- Extreme Heat Tab -------------------------------------------   
    
    tabItem(tabName = "heat",
            fluidPage(
              box(
                title = h2(tags$strong("Extreme Heat")),
                "School",
                
                width = NULL,
                style = "height: 800px",
                fluidRow(
                  box(
                    width = 6,
                    plotlyOutput(outputId = 'extreme_heat_plotly')
                    
                  ),
                  column(
                    width = 6,
                    box(
                      width = NULL,
                      includeMarkdown("text/heat.md")
                      
                    )
                  ))
              )#END BOX
              
            )#END FluidPage
      
            ),#END HEAT TAB
    
    # --------- Wildfire Tab -----------------------------------------------
    tabItem(tabName = "wildfire",
            fluidPage(
              box(
                title = h2(tags$strong("Wildfire")),
                div(style = "display: flex; align-items: center; justify-content: space-between;",
                            
                            # school name
                            uiOutput("school_name"),
                            
                            # school picker for the hazards tab, note the different inputId than the school picker in the welcome
                            box(width = NULL,
                                pickerInput(inputId = "school_input",
                                            label = "Select school",
                                            choices = unique(sb_hazards_test$SchoolName),
                                            options = pickerOptions(actionsBox = TRUE),
                                            selected = "Dos Pueblos Senior High", 
                                            multiple = FALSE),
                            )
                ),
                width = NULL,
                fluidRow(
                  box(
                    width = 6,
                    leafletOutput(outputId = "wildfire_map")
                  ),
                  column(
                    width = 6,
                    box(
                      width = NULL,
                      includeMarkdown("text/wildfire.md")
                      
                    )
                  ))
              )#END BOX
              
            )#END FluidPage
    
            
            ),#END Wildfire
    
  
    # --------- Precipitation Tab ------------------------------------------
    
    tabItem(tabName = "precipitation",
            fluidPage(
              box(
                title = h2(tags$strong("Extreme Precipitation")),
                width = NULL,
                style = "height: 800px",
                fluidRow(
                  tags$style(".nav-tabs-custom {box-shadow:none;}"),
                  
                  # plot output
                  box(
                    width = 6,
                    style = "border: none; border-width:0;",
                    plotlyOutput(outputId = 'extreme_precip1')
                  ),
                  
                  # text output
                  column(
                    width = 6,
                    box(
                      width = NULL,
                      
                      # Load in text 
                      includeMarkdown("text/precipitation.md")
                      
                    )
                  )
                  
                )
                
              )#END BOX
              
            )#END FluidPage
            
    ),#END Flooding
    
    # --------- Flooding Tab------------------------------------
    
    
    tabItem(tabName = "flooding",
            fluidPage(
              box(
                title = h2(tags$strong("Flooding")),
                width = NULL,
                style = "height: 800px",
                fluidRow(
                  box(
                    width = 6,
                    tags$head(tags$style(HTML('.box{-webkit-box-shadow: none; -moz-box-shadow: none;box-shadow: none;}'))),
                    
                    # Plot here
                    
                  ),
                  column(
                    width = 6,
                    box(
                      width = NULL,
                      tags$head(tags$style(HTML('.box{-webkit-box-shadow: none; -moz-box-shadow: none;box-shadow: none;}'))),
                      style = "border: none; border-width:0;",
                      includeMarkdown("text/flooding.md")
                      
                    )
                  ))
              )#END BOX
              
            )#END FluidPage
            
    ),#END FLOODING TAB
    
    # --------- Sea Level Rise Tab ------------------------------------------
    
    
    tabItem(tabName = "sea_rise",
            fluidPage(
              box(
                title = h2(tags$strong("Sea Level Rise")),
                width = NULL,
                style = "height: 800px",
                "fire",
                fluidRow(
                  box(
                    width = 6,
                    tags$head(tags$style(HTML('.box{-webkit-box-shadow: none; -moz-box-shadow: none;box-shadow: none;}'))),
                    
                    # Plot here
                    
                    
                  ),
                  column(
                    width = 6,
                    box(
                      width = NULL,
                      tags$head(tags$style(HTML('.box{-webkit-box-shadow: none; -moz-box-shadow: none;box-shadow: none;}'))),
                      style = "border: none; border-width:0;",
                      includeMarkdown("text/coastal_inundation.md")
                      
                    )
                  ))
              )#END BOX
              
            )#END FluidPage
            
    ),#END SEA LEVEL RISE TAB
  
    
    # ------- Climate Information tab -----------------------------------
    # this will describe time concepts, how, why, etc...
    
    tabItem(tabName = "info",
            fluidPage(
              box(
                  title = h2(tags$strong("Information")),
                  width = NULL,
                  style = "height: 800px",
                  includeMarkdown("text/socio.md"),
              )
            )#END FLUIDPAGE
    ),#END Climate Info TAB
    
    
    # ------- Glossary tab ---------------------------------------------
    tabItem(tabName = "glossary",
            fluidPage(
              box(
                  title = h2(tags$strong("Glossary")),
                  width = NULL,
                  style = "height: 800px",
                  
              )# END Box
              
            )# END FluidPage
            
            
    ),#END Glossary
    

    # ------- User guide tab -----------------------
    tabItem(tabName = "user",
            fluidPage(
              box(
                  title = h2(tags$strong("User Guide")),
                  width = NULL,
                  style = "height: 800px",
                  
                  )# END Box
              
            )# END FluidPage
            
            
    )#END USER GUIDE
    
  )#END TABS CONTENT
  
)#END BODY

# -------- Combine all in dashboardPage----------------
dashboardPage(header, sidebar, body,skin = "yellow")
