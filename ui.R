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
                  
                  fluidRow(
                    
                    # START SELECT CITY, DISTRICT, AND SCHOOL COLUMN
                    column(width = 4,
                           # label
                           h3(tags$strong("Select a school to get started")),
                           # city selection
                           uiOutput("cityMenu"),
                           # district selection
                           uiOutput("districtMenu"),
                           # school selection
                           uiOutput("schoolMenu"),
                           # map with school buffer output
                           leafletOutput("map") %>% 
                             withSpinner(color="#0dc5c1")),
                    # END SELECT CITY, DISTRICT, AND SCHOOL COLUMN
                    
                    # START HAZARD SUMMARY PLOT COLUMN
                    column(width = 8,
                           # output plot title
                           div(style = "text-align:center;",
                               h3(tags$strong("Hazard Summary"))),
                           # output summary score
                           div(style = "text-align:center;",
                               uiOutput("summary_score_home")),
                           # output summary plot
                           plotOutput("summary_home") %>% 
                             withSpinner(color="#0dc5c1"))
                    # END HAZARD SUMMARY PLOT COLUMN
                    
                    )
                  
              ))),
    
    
    # --------- Hazard Summary Metric tab --------------------------------   
    tabItem(tabName = "index",
            # Content for the index tab
            fluidPage(
              
              box(width = NULL,
                  title = h2(tags$strong("Hazard Summary Metric")),
                  fluidRow(
                    column(4,
                           # output school name as tab title
                           uiOutput("school_name_summary")
                    ),
                    # school dropdown
                    column(6,
                           selectInput(
                             inputId = "school_summary",
                             label = "Select or type another school in the same district:",
                             choices = sort(unique(hazards_test$SchoolName)),
                             selected = NULL
                             
                           )#END Picker
                    )#END Picker column
                    
                    
                  ),#END FLUID ROW
                  
                  box(
                    width = NULL, 
                    # output summary score
                    div(style = "text-align:center;",
                        uiOutput("summary_score_tab")),
                    # output summmary plot
                    plotOutput(outputId = "summary_tab") %>% 
                      withSpinner(color="#0dc5c1")
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
                    # output school name as tab title
                    uiOutput("school_name_heat"),
                    tags$div(style = "margin-top: 50px;"),
                      radioGroupButtons(
                        inputId = "change_heat_plot",
                        label = "View data in different format",
                        choices = c("Bar plot", "Line graph")
                      )
                  ),
                  # school dropdown
                  column(6,
                         selectInput(
                           inputId = "school_heat",
                           label = "Select or type another school in the same district:",
                           choices = sort(unique(extreme_heat$SchoolName)),
                           selected = NULL
                         )
                  ),

                ),
                box(
                  width = NULL,
                  plotlyOutput(outputId = "heat_plot") %>% 
                    withSpinner(color="#0dc5c1"),
                  includeMarkdown("text/heat.md")
                  
                )
              )
            )),#END EXTREME HEAT
    
        # --------- Wildfire Tab -----------------------------------------------
    
    tabItem(tabName = "wildfire",
            fluidPage(
              box(
                title = h2(tags$strong("Wildfire")),
                width = NULL,
                fluidRow(
                  column(4,
                         # output school name as tab title
                         uiOutput("school_name_wildfire"),
                  ),
                  
                  # school dropdown
                  column(6, 
                         selectInput(inputId = "school_wildfire",
                                     label = "Select or type another school in the same district:",
                                     choices = sort(unique(schools_buffers$SchoolName)),
                                     selected = NULL)
                  )
                  
                ),
                box(
                  width = NULL,
                  column(
                    width = 6,
                    # column title
                    div(
                      style = "text-align: left; font-weight: bold; padding-bottom: 10px; font-size: 24px;",
                      "2012 wildfire hazard"
                    ),
                    leafletOutput(outputId = "wildfire_map2012") %>%
                      withSpinner(color="#0dc5c1")
                  ),
                  column(
                    width = 6,
                    # column title
                    div(
                      style = "text-align: left; font-weight: bold; padding-bottom: 10px; font-size: 24px;",
                      "2023 wildfire hazard"
                    ),
                    leafletOutput(outputId = "wildfire_map2023") %>%
                      withSpinner(color="#0dc5c1")
                  ),
                  includeMarkdown("text/wildfire.md")
                )
              )
            )),#END Wildfire 
    

    # --------- Precipitation Tab ------------------------------------------
    
    tabItem(tabName = "precipitation",
            fluidPage(
              box(
                title = h2(tags$strong("Extreme Precipitation")),
                width = NULL,
                fluidRow(
                  column(4,
                         # output school name as tab title
                         uiOutput("school_name_precip"),
                         radioGroupButtons(
                           inputId = "change_precip_plot",
                           label = "View data in different format",
                           choices = c("Bar plot", "Line graph")
                         )
                  ),
                  
                  # school dropdown
                  column(6, 
                         selectInput(inputId = "school_precip", 
                                     label = "Select or type another school in the same district:", 
                                     choices = sort(unique(extreme_precip$SchoolName)), 
                                     selected = NULL)
                  ),
                  
                ),
                
                box(
                  width = NULL,
                  plotlyOutput(outputId = 'precip_plot') %>% 
                    withSpinner(color="#0dc5c1"),
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
                         # output school name as tab title
                         uiOutput("school_name_flood")
                  ),
                  # school dropdown
                  column(6, 
                         selectInput(
                           inputId = "school_flooding",
                           label = "Select or type another school in the same district:",
                           choices = sort(unique(hazards_test$SchoolName)),
                           selected = NULL
                         )
                  ),
                  
                ),
                
                box(
                  width = NULL,
                  leafletOutput(outputId = "flood_map") %>% 
                    withSpinner(color="#0dc5c1"),
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
                fluidRow(
                  column(4,
                         # output school name as tab title
                         uiOutput("school_name_slr")
                  ),
                  # school dropdown
                  column(6, 
                         selectInput(
                           inputId = "school_slr",
                           label = "Select or type another school in the same district:",
                           choices = sort(unique(hazards_test$SchoolName)),
                           selected = NULL
                         )
                  ),
                  
                ),
                
                box(
                  width = NULL,
                  leafletOutput(outputId = "slr_map") %>% 
                    withSpinner(color="#0dc5c1"),
                  includeMarkdown("text/coastal_inundation.md")
                  
                )
              ))
    ),#END SEA LEVEL RISE
    
    
    # ------- Climate Information tab -----------------------------------
    # this will describe time concepts, how, why, etc...
    
    tabItem(tabName = "info",
            fluidPage(
              box(
                title = h2(tags$strong("Information")),
                width = NULL,
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

              )# END Box
              
            )# END FluidPage
            
            
    ),#END Glossary
    
    
    # ------- User guide tab -----------------------
    tabItem(tabName = "user",
            fluidPage(
              box(
                title = h2(tags$strong("User Guide")),
                width = NULL,

              )# END Box
              
            )# END FluidPage
            
            
    )#END USER GUIDE
    
  )#END TABS CONTENT
  
)#END BODY

# -------- Combine all in dashboardPage----------------
dashboardPage(header, sidebar, body,skin = "yellow")

