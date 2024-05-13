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
                  #style = "height: 800px",
                  title = h3(tags$strong("Welcome to the CASAschools Climate Hazards Dashboard!")),
                  includeMarkdown("text/about_text.md"),
                  h3(tags$strong("Getting Started")),
                  # sidebarLayout(
                  #   sidebarPanel(
                  #     uiOutput("cityMenu"),
                  #     uiOutput("districtMenu"),
                  #     uiOutput("schoolMenu")
                  #   ),
                  fluidRow(
                    column(width = 4,
                           uiOutput("cityMenu"),
                           uiOutput("districtMenu"),
                           uiOutput("schoolMenu"),
                           leafletOutput("map")),
                    # column(width = 8,
                    #        plotOutput("hazard_summary"))
                    
                    ),
                  # mainPanel(
                  #   leafletOutput("map")
                  
              ))),
    
    
    # --------- Hazard Summary Metric tab --------------------------------   
    tabItem(tabName = "index",
            # Content for the index tab
            fluidPage(
              
              box(width = NULL,
                  style = "height: 800px",
                  title = h2(tags$strong("Hazard Summary Metric")),
                  fluidRow(
                    column(4,
                           "City Name and School District",
                           #uiOutput("school_name)
                    ),
                    column(4,
                           selectInput(
                             inputId = "index_school",
                             label = "School",
                             choices = unique(hazards_test$SchoolName),
                             multiple = FALSE
                             
                           )#END Picker
                    )#END Picker column
                    
                    
                  ),#END FLUID ROW
                  
                  box(
                    width = NULL,
                    plotOutput(outputId = "hazard_summary")
                  )
              )
              
            )#END FLUIDPAGE
    ),#END INDEX
    # ---------- Explore Your Hazards Sub Tabs -----------------------------
    
    # --------- Extreme Heat Tab -------------------------------------------   
    
    tabItem(tabName = "heat",
            fluidPage(
              box(
                title = h2(tags$strong("Extreme Heat")),
                width = NULL,
                fluidRow(
                  column(4,
                         "City Name and School District",
                         #uiOutput("school_name")
                  ),
                  column(4, 
                         pickerInput(
                           inputId = "heat_school",
                           label = "School",
                           choices = unique(hazards_test$SchoolName),
                           multiple = FALSE
                         )
                  ),
                  
                ),
                box(
                  width = NULL,
                  plotlyOutput(outputId = 'extreme_heat_plotly'),
                  includeMarkdown("text/heat.md")
                  
                )
              ))
    ),#END EXTREME HEAT
    
    # --------- Wildfire Tab -----------------------------------------------
    
    tabItem(tabName = "wildfire",
            fluidPage(
              box(
                title = h2(tags$strong("Wildfire")),
                width = NULL,
                fluidRow(
                  column(4,
                         
                         # school name output
                         uiOutput("school_name"),
                  ),
                  column(6, 
                         selectInput(inputId = "school_input",
                                     label = "Select School in School District:",
                                     choices = unique(schools_buffers$SchoolName),
                                     #options = pickerOptions(actionsBox = TRUE),
                                     multiple = FALSE)
                  )
                  
                  
                ),
                box(
                  width = NULL,
                  leafletOutput(outputId = "wildfire_map"),
                  includeMarkdown("text/wildfire.md")
                  
                )
              )
            )),#END Wildfire 
    
    
    
    
    
    # 
    # 
    # 
    # tabItem(tabName = "wildfire",
    #         fluidPage(
    #           box(
    #             title = h2(tags$strong("Wildfire")),
    #             width = NULL,
    #             fluidRow(
    #               column(4,
    #             #div(style = "display: flex; align-items: center; justify-content: space-between;",
    #               
    #                         # school name
    #                         uiOutput("school_name"),
    #               ),
    #             column(4,
    #                         
    #                         # school picker for the hazards tab, note the different inputId than the school picker in the welcome
    #                 width = NULL,
    #                     pickerInput(inputId = "school_input",
    #                                 label = "Select school",
    #                                 choices = unique(schools_buffers$SchoolName),
    #                                 options = pickerOptions(actionsBox = TRUE),
    #                                 selected = "Dos Pueblos Senior High", 
    #                                 multiple = FALSE)
    #                 )        
    #                 
    #             ),
    #             fluidRow(
    #               box(
    #                 width = 6,
    #                 leafletOutput(outputId = "wildfire_map"),
    #               
    #              
    #                   includeMarkdown("text/wildfire.md")
    #                   
    #                 )
    #               ))
    #           )#END BOX
    #           
    #         ),#END FluidPage
    # 
    #         
    #         #),#END Wildfire
    
    
    # --------- Precipitation Tab ------------------------------------------
    
    tabItem(tabName = "precipitation",
            fluidPage(
              box(
                title = h2(tags$strong("Extreme Precipitation")),
                width = NULL,
                style = "height: 800px",
                fluidRow(
                  column(4,
                         "City Name and School District",
                         #uiOutput("school_name")
                  ),
                  
                  
                  
                  
                  column(4, 
                         # pickerInput(
                         #   inputId = "precip_school",
                         #   label = "School",
                         #   choices = unique(hazards_test$SchoolName),
                         #   multiple = FALSE
                         
                         pickerInput("schoolPicker", "Select a School:", 
                                     choices = unique(names_precip_merge$SchoolName), 
                                     selected = unique(names_precip_merge$SchoolName)[1],
                                     multiple = FALSE)
                  ),
                  
                ),
                
                box(
                  width = NULL,
                  plotlyOutput(outputId = 'extreme_precipitation_plotly'),
                  includeMarkdown("text/heat.md")
                  
                )
              ))
    ),#END EXTREME PRECIPITATION
    
    # --------- Flooding Tab------------------------------------
    
    tabItem(tabName = "flooding",
            fluidPage(
              box(
                title = h2(tags$strong("Flooding")),
                width = NULL,
                style = "height: 800px",
                fluidRow(
                  column(4,
                         "City Name and School District",
                         #uiOutput("school_name")
                  ),
                  column(4, 
                         pickerInput(
                           inputId = "flooding_school",
                           label = "School",
                           choices = unique(hazards_test$SchoolName),
                           multiple = FALSE
                         )
                  ),
                  
                ),
                
                box(
                  width = NULL,
                  #plot
                  includeMarkdown("text/flooding.md")
                  
                )
              ))
    ),#END FLOODING
    
    # --------- Sea Level Rise Tab ------------------------------------------
    
    
    tabItem(tabName = "sea_rise",
            fluidPage(
              box(
                title = h2(tags$strong("Sea Level Rise")),
                width = NULL,
                style = "height: 800px",
                fluidRow(
                  column(4,
                         "City Name and School District",
                         #uiOutput("school_name")
                  ),
                  column(4, 
                         pickerInput(
                           inputId = "sea_school",
                           label = "School",
                           choices = unique(hazards_test$SchoolName),
                           multiple = FALSE
                         )
                  ),
                  
                ),
                
                box(
                  width = NULL,
                  #plot
                  includeMarkdown("text/coastal_inundation.md")
                  
                )
              ))
    ),#END EXTREME PRECIPITATION
    
    
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

