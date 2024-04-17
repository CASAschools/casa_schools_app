# -------- dashboard Header--------------------------
header <- dashboardHeader(
  
  title = "CASA Schools Climate Hazards",
  titleWidth = 400
) #END dashboardHeader


# -------- dashboard Sidebar--------------------------
sidebar <- dashboardSidebar(
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = h4("Welcome"), tabName = "welcome", icon = icon("star")),
    menuItem(text = h4("Index"), tabName = "index", icon = icon("map")),
    menuItem(text = h4(HTML("Explore Your Hazards")), tabName = "hazards", icon = icon("school")),
    menuItem(text = h4("Socioeconomic"), tabName = "socio", icon = icon("person")),
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
          title = h3(tags$strong("Welcome!")),
          includeMarkdown("text/about_text.md"),
          h3(tags$strong("Getting Started")),
          leafletOutput("map")
      )
    )
  ),

    
    
# --------- Index tab --------------------------------   
  tabItem(tabName = "index",
      # Content for the index tab
      fluidPage()#END FLUIDPAGE
      
    ),#END INDEX


# ---------- Hazards tab -----------------------------
  tabItem(tabName = "hazards",
      fluidPage(
        box(
          width = NULL,
          title = h2(tags$strong("Santa Paula Unified School district")),
          tabsetPanel(
            tabPanel(h4("Extreme Heat"),
              fluidRow(
                tags$style(".nav-tabs-custom {box-shadow:none;}"),
                box(width = 6,
                  style = "border: none; border-width:0;",
                  plotOutput('hazard_plot')
                ),
                column(width = 6,
                  box(
                    width = NULL,
                    style = "border: none; border-width:0;",
                    includeMarkdown("text/heat.md")
                    
                  )
                )
              )
            ),#END EXTREME HEAT
            tabPanel(h4("Extreme Precipitation")),#END EXTREME PRECIPITATION
            tabPanel(h4("Wildfire")),#END WILDFIRE
            tabPanel(h4("Flooding")),#END FLOODING
            tabPanel(h4("Sea Level Rise"))#END SEA LEVEL RISE
          )
        )
      )
    ),#END HAZARDS TAB

# ------- Socioeconomic tab ---------------------
  tabItem(tabName = "socio",
      fluidPage(
        box(width = NULL,
          # Content for the socioeconomic tab
        )
      )#END FLUIDPAGE
    ),#END SOCIOECONOMIC TAB
# ------- User guide tab -----------------------
  tabItem(tabName = "guide",
          )#END USER GUIDE

)#END TABS CONTENT
)#END BODY

# -------- Combine all in dashboardPage----------------
dashboardPage(header, sidebar, body,skin = "yellow")
