# -------- dashboard Header--------------------------

# BEGIN DASHBOARD HEADER
header <- dashboardHeader(
  
  # dashboard title
  title = tags$strong("CA Schools Climate Hazards", style = "font-size: 16.5px;"),
  # title width
  titleWidth = 258
) 
# END DASHBOARD HEADER

# -------- dashboard Sidebar--------------------------

# BEGIN DASHBOARD SIDEBAR
sidebar <- dashboardSidebar(
  width = 300,
  
  # BEGIN SIDEBAR MENU
  sidebarMenu(
    # welcome tab
    menuItem(text = h4("Welcome"), tabName = "welcome", icon = icon("star")),
    # hazard summary tab
    menuItem(text = h4("Hazards Summary"), tabName = "index", icon = icon("square-poll-horizontal")),
    # explore your hazards tab
    menuItem(text = h4("Explore Your Hazards"), tabName = "hazards", icon = icon("earth-americas"),
             # extreme heat sub tab
             menuSubItem(text = h4("Extreme Heat"), tabName = "heat", icon = icon("temperature-arrow-up")),
             # wildfire sub tab
             menuSubItem(text = h4("Wildfire"), tabName = "wildfire", icon = icon("fire")),
             # extreme precipitation sub tab
             menuSubItem(text = h4("Extreme Precipitation"), tabName = "precipitation", icon = icon("cloud-showers-heavy")),
             # flooding sub tab
             menuSubItem(text = h4("Flooding"), tabName = "flooding", icon = icon("house-flood-water")),
             # sea level rise sub tab
             menuSubItem(text = h4("Sea Level Rise"), tabName = "sea_rise", icon = icon("house-tsunami"))
    ),
    # Information tab
    menuItem(text = h4("Information"), tabName = "info", icon = icon("circle-info")),
    # glossary tab
    menuItem(text = h4("Glossary"), tabName = "glossary", icon = icon("book-open")),
    # user guide tab
    menuItem(text = h4("User Guide"), tabName = "user", icon = icon("users"))
    
  ) # END SIDEBAR MENU
  
) # END DASHBOARD SIDEBAR


# -------- dashboard Body-----------------------------

# BEGIN DASHBOARD BODY
body <- dashboardBody(
  
  # BEGIN ALL TABS
  tabItems(
    
    # ---------- Welcome tab ----------------------------- 
    
    # BEGIN WELCOME TAB
    tabItem(tabName = "welcome",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("Welcome to the California Schools Climate Hazards Dashboard!"), style = "font-size: 35px"),
                # text description
                includeMarkdown("text/about_text.md"),
                
                # BEGIN FLUID ROW FOR SCHOOL SELECTION AND HAZARD SUMMARY PLOT
                fluidRow(
                  
                  # START SELECT CITY, DISTRICT, AND SCHOOL COLUMN
                  column(width = 4,
                         # label
                         h3(tags$strong("Select your school:")),
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
                         # output plot title with school name
                         div(style = "text-align:center;",
                             uiOutput("summary_title_home")),
                         # output summary plot
                         plotOutput("summary_home") %>% 
                           withSpinner(color="#0dc5c1"))
                  # END HAZARD SUMMARY PLOT COLUMN
                  
                ) # END FLUID ROW FOR SCHOOL SELECTION AND HAZARD SUMMARY PLOT
                
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ), # END WELCOME TAB
    
    
    # --------- Hazard Summary tab --------------------------------   
    
    # BEGIN INDEX TAB
    tabItem(tabName = "index",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("Hazards Summary"), style = "font-size: 35px"),
                # school name
                uiOutput("school_name_summary"),
                
                # BEGIN FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                fluidRow(
                  # school dropdown
                  column(
                    width = 4, 
                    selectInput(inputId = "school_summary",
                                label = "Select or type another school in the same district:",
                                choices = sort(unique(schools_buffers$SchoolName)),
                                selected = NULL)
                  ),
                  # empty column for space in between 
                  column(width = 4),
                  # interactivity
                  column(
                    width = 3,
                    # empty title to add space
                    h2(tags$strong("")),
                    # highlight interactive elements button
                    actionButton(inputId = "tutorial_summary",
                                 label = "Highlight Interactive Elements")
                  )
                ),
                # END FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                
                # BEGIN BOX FOR PLOT
                box(
                  width = NULL, 
                  # output summary score
                  div(style = "text-align:center;",
                      uiOutput("summary_score_tab")),
                  # output summmary plot
                  plotOutput(outputId = "summary_tab") %>% 
                    withSpinner(color="#0dc5c1"),
                  # description
                  includeMarkdown("text/summary.md")
                )
                # END BOX FOR PLOT
                
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ), # END INDEX TAB
    
    # ---------- Explore Your Hazards Sub Tabs -----------------------------
    
    # --------- Extreme Heat Tab -------------------------------------------   
    
    # BEGIN HEAT TAB
    tabItem(tabName = "heat",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("Extreme Heat"), style = "font-size: 35px"),
                # school name
                uiOutput("school_name_heat"),
                
                # BEGIN FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                fluidRow(
                  # school dropdown
                  column(
                    width = 4, 
                    selectInput(inputId = "school_heat",
                                label = "Select or type another school in the same district:",
                                choices = sort(unique(schools_buffers$SchoolName)),
                                selected = NULL)
                  ),
                  # empty column for space in between 
                  column(width = 4),
                  # highlight interactive elements
                  column(
                    width = 3,
                    # empty title to add space
                    h2(tags$strong("")),
                    # highlight interactive elements button
                    actionButton(inputId = "tutorial_heat",
                                 label = "Highlight Interactive Elements")
                  )
                ),
                # END FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                
                # BEGIN BOX FOR PLOT
                box(
                  width = NULL,
                  # output extreme heat plot
                  plotlyOutput(outputId = "heat_plot") %>% 
                    withSpinner(color="#0dc5c1"),
                  # output extreme heat text
                  includeMarkdown("text/heat.md")
                )
                # END BOX FOR PLOT
                
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ), # END HEAT TAB
    
    # ------------------------Wildfire Tab-------------------------------
    
    # BEGIN WILDFIRE TAB
    tabItem(tabName = "wildfire",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("Wildfire"), style = "font-size: 35px"),
                # school name
                uiOutput("school_name_wildfire"),
                
                # BEGIN FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                fluidRow(
                  # school dropdown
                  column(
                    width = 4, 
                    selectInput(inputId = "school_wildfire",
                                label = "Select or type another school in the same district:",
                                choices = sort(unique(schools_buffers$SchoolName)),
                                selected = NULL)
                  ),
                  # empty column for space in between 
                  column(width = 4),
                  # highlight interactive elements
                  column(
                    width = 3,
                    h2(tags$strong("")),
                    # action button
                    actionButton(inputId = "tutorial_wildfire",
                                 label = "Highlight Interactive Elements")
                  )
                ),
                # END FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                
                # BEGIN BOX FOR MAPS AND DESCRIPTION
                box(
                  width = NULL,
                  # 2012 wildfire hazard map
                  column(
                    width = 6,
                    # map title
                    div(style = "text-align: left; font-weight: bold; padding-bottom: 10px; font-size: 24px;",
                        "2012 Wildfire Hazard" ),
                    # map output
                    leafletOutput(outputId = "wildfire_map2012") %>%
                      withSpinner(color="#0dc5c1")
                  ),
                  # 2023 wildfire hazard map
                  column(
                    width = 6,
                    # map title
                    div(style = "text-align: left; font-weight: bold; padding-bottom: 10px; font-size: 24px;",
                        "2023 Wildfire Hazard"),
                    # map output
                    leafletOutput(outputId = "wildfire_map2023") %>%
                      withSpinner(color="#0dc5c1")
                  ),
                  # description text
                  box(width = 12),
                  includeMarkdown("text/wildfire.md")
                ) 
                # END BOX FOR MAPS AND DESCRIPTION
                
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ), # END WILDFIRE TAB
    
    # --------- Precipitation Tab ------------------------------------------
    
    # BEGIN PRECIP TAB
    tabItem(tabName = "precipitation",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("Extreme Precipitation"), style = "font-size: 35px"),
                # school name
                uiOutput("school_name_precip"),
                
                # BEGIN FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                fluidRow(
                  # school dropdown
                  column(
                    width = 4, 
                    selectInput(inputId = "school_precip",
                                label = "Select or type another school in the same district:",
                                choices = sort(unique(schools_buffers$SchoolName)),
                                selected = NULL)
                  ),
                  # empty column for space in between 
                  column(width = 4),
                  # highlight interactive elements
                  column(
                    width = 3,
                    h2(tags$strong("")),
                    # action button
                    actionButton(inputId = "tutorial_precip",
                                 label = "Highlight Interactive Elements")
                  )
                ),
                # END FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                
                # BEGIN BOX FOR PLOT
                box(
                  width = NULL,
                  # output precip plot
                  plotlyOutput(outputId = 'precip_plot') %>% 
                    withSpinner(color="#0dc5c1"),
                  # output precip text
                  includeMarkdown("text/precipitation.md")
                )
                # END BOX FOR PLOT
                
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ), # END PRECIP TAB
    
    # --------- Flooding Tab------------------------------------
    
    # BEGIN FLOODING TAB 
    tabItem(tabName = "flooding",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("Flooding"), style = "font-size: 35px"),
                # school name
                uiOutput("school_name_flood"),
                
                # BEGIN FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                fluidRow(
                  # school dropdown
                  column(
                    width = 4, 
                    selectInput(inputId = "school_flooding",
                                label = "Select or type another school in the same district:",
                                choices = sort(unique(schools_buffers$SchoolName)),
                                selected = NULL)
                  ),
                  # empty column for space in between 
                  column(width = 4),
                  # highlight interactive elements
                  column(
                    width = 3,
                    h2(tags$strong("")),
                    # action button
                    actionButton(inputId = "tutorial_flooding",
                                 label = "Highlight Interactive Elements")
                  )
                ),
                # END FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                
                # BEGIN BOX FOR MAP AND DESCRIPTION
                box(
                  width = NULL,
                  # output flooding map
                  leafletOutput(outputId = "flood_map") %>% 
                    withSpinner(color="#0dc5c1"),
                  box(width = 12),
                  # output text
                  includeMarkdown("text/flooding.md")
                ) 
                # END BOX FOR MAP AND DESCRIPTION
                
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ), # END FLOODING TAB
    
    # --------- Sea Level Rise Tab ------------------------------------------
    
    # BEGIN SEA LEVEL RISE TAB
    tabItem(tabName = "sea_rise",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("Sea Level Rise"), style = "font-size: 35px"),
                # school name
                uiOutput("school_name_slr"),
                
                # BEGIN FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                fluidRow(
                  # school dropdown
                  column(
                    width = 4, 
                    selectInput(inputId = "school_slr",
                                label = "Select or type another school in the same district:",
                                choices = sort(unique(schools_buffers$SchoolName)),
                                selected = NULL)
                  ),
                  # empty column for space in between 
                  column(width = 4),
                  # highlight interactive elements
                  column(
                    width = 3,
                    h2(tags$strong("")),
                    # action button
                    actionButton(inputId = "tutorial_slr",
                                 label = "Highlight Interactive Elements")
                  )
                ),
                # END FLUID ROW FOR INTERACTIVITY AND SCHOOL DROPDOWN BUTTONS
                
                # BEGIN BOX FOR MAPS AND DESCRIPTION
                box(
                  width = NULL,
                  # 2000 sea level rise map
                  column(
                    width = 6,
                    # map title
                    div(style = "text-align: left; font-weight: bold; padding-bottom: 10px; font-size: 24px;",
                        HTML("2000 Sea Levels<br>with a Coastal Storm")),
                    # map output
                    leafletOutput(outputId = "slr_map_2000") %>%
                      withSpinner(color="#0dc5c1")
                  ),
                  # 2050
                  column(
                    width = 6,
                    # map title
                    div(style = "text-align: left; font-weight: bold; padding-bottom: 10px; font-size: 24px;",
                        HTML("Projected 2050 Sea Levels<br>with a Coastal Storm")),
                    # map output
                    leafletOutput(outputId = "slr_map") %>%
                      withSpinner(color="#0dc5c1")
                  ),
                  box(width = 12),
                  # output slr text
                  includeMarkdown("text/slr.md")
                )
                # END BOX FOR MAPS AND DESCRIPTION
                
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ), # END SEA LEVEL RISE TAB
    
    # ------- Information tab -----------------------------------
    
    # BEGIN INFORMATION TAB
    tabItem(tabName = "info",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("Information"), style = "font-size: 35px"),
                # text
                includeMarkdown("text/socio.md"),
              )
              # END BOX FOR ENTIRE PAGE
              
            )# END FLUID PAGE
            
    ), # END INFORMATION TAB
    
    # ------- Glossary tab ---------------------------------------------
    
    # BEGIN GLOSSARY TAB
    tabItem(tabName = "glossary",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL, 
                # title 
                h2(tags$strong("Glossary"), style = "font-size: 35px"),
                # text
                includeMarkdown("text/glossary.md")
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ), # END GLOSSARY TAB
    
    # ------- User guide tab -----------------------
    
    # BEGIN USER GUIDE TAB
    tabItem(tabName = "user",
            
            # BEGIN FLUID PAGE
            fluidPage(
              
              # BEGIN BOX FOR ENTIRE PAGE
              box(
                width = NULL,
                # title
                h2(tags$strong("User Guide"), style = "font-size: 35px"),
                # text
                includeMarkdown("text/glossary.md")
              ) # END BOX FOR ENTIRE PAGE
              
            ) # END FLUID PAGE
            
    ) # END USER GUIDE TAB
    
  ) # END ALL TABS
  
) # END DASHBOARD BODY

# -------- Combine all in dashboardPage----------------
dashboardPage(header, sidebar, body, skin = "yellow")

