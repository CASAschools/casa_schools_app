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
                           leafletOutput("map") %>% 
                             withSpinner(color="#0dc5c1")
                           
                           
                           ),
                    column(width = 8,
                           plotOutput("summary_homepage") %>% 
                             withSpinner(color="#0dc5c1") )
                    
                    ),
                  # mainPanel(
                  #   leafletOutput("map")
                  
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
                             label = "Select another school in the same district:",
                             choices = unique(hazards_test$SchoolName),
                             multiple = FALSE
                             
                           )#END Picker
                    )#END Picker column
                    
                    
                  ),#END FLUID ROW
                  
                  box(
                    width = NULL,
                    plotOutput(outputId = "summary_sumtab") %>% 
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
                  ),
                  # school dropdown
                  column(6, 
                         selectInput(
                           inputId = "school_heat",
                           label = "Select another school in the same district:",
                           choices = unique(extreme_heat$SchoolName),
                           multiple = FALSE
                         )
                  ),

                ),
                box(
                  width = NULL,
                  plotlyOutput(outputId = "extreme_heat_plotly") %>% 
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
                                     label = "Select another school in the same district:",
                                     choices = unique(schools_buffers$SchoolName),
                                     multiple = FALSE)
                  )
                  
                  
                ),
                # box(
                #   width = NULL,
                #   leafletOutput(outputId = "wildfire_map2012") %>% 
                #     withSpinner(color="#0dc5c1"),
                #   leafletOutput(outputId = "wildfire_map2023") %>% 
                #     withSpinner(color="#0dc5c1"),
                #   includeMarkdown("text/wildfire.md")
                # )
                box(
                  width = NULL,
                  column(
                    width = 6,
                    leafletOutput(outputId = "wildfire_map2012") %>%
                      withSpinner(color="#0dc5c1")
                  ),
                  column(
                    width = 6,
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
                         uiOutput("school_name_precip")
                  ),
                  
                  # school dropdown
                  column(6, 
                         selectInput(inputId = "school_precip", 
                                     label = "Select another school in the same district:", 
                                     choices = unique(names_precip_merge$SchoolName), 
                                     selected = unique(names_precip_merge$SchoolName)[1],
                                     multiple = FALSE)
                  ),
                  
                ),
                
                box(
                  width = NULL,
                  plotlyOutput(outputId = 'extreme_precipitation_plotly') %>% 
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
                           label = "Select another school in the same district:",
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
                fluidRow(
                  column(4,
                         # output school name as tab title
                         uiOutput("school_name_slr")
                  ),
                  # school dropdown
                  column(6, 
                         selectInput(
                           inputId = "school_slr",
                           label = "Select another school in the same district:",
                           choices = unique(hazards_test$SchoolName),
                           multiple = FALSE
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

