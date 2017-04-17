library(shiny)
library(shinydashboard)
library(leaflet)

dashboardPage(
  dashboardHeader(title = "Philadelphia Permits Browser", titleWidth = 250),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Map of Philadelphia", tabName = "map", icon = icon("map")),
      menuItem("Graphs & Metrics", tabName = "graphs", icon = icon("signal", lib = "glyphicon")),
      menuItem("About", tabName = "about", icon = icon("question-circle")),
      menuItem("Source Code", href = "http://github.com/YunS-Stacy/PHL_Permits_Browser", icon = icon("github-alt"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "map",
      fluidRow(
        column(width = 8,
               box(width = NULL,
                   leafletOutput("permits_map", height = 500))
        ),
        column(width = 3,
               box(width = NULL,
                   dateRangeInput("date1", "Select dates to visualize.",
                                  start = "2017-03-01", end = "2017-03-31",
                                  min = min(permits$permitdate), max = max(permits$permitdate))
               ),
               box(width = NULL,
                   h4("Number of permitss"),
                   h5(textOutput("total_permits"))),
               box(width = NULL,
                   h4("Most Common permits"),
                   h5(textOutput("common_permits"))),
               box(width = NULL,
                   h4("Day of the Week with the Most permits"),
                   h5(textOutput("weekday_permits")))
        )
      )
      ),
      tabItem(tabName = "graphs",
              fluidRow(
                column(width = 6,
                       box(width = NULL,
                           plotOutput("daily_plot"))),
                column(width = 6,
                       box(width = NULL,
                           plotOutput("desc_plot")))
              ),
              fluidRow(
                column(width = 3,
                       box(width = NULL,
                           dateRangeInput("date2", "Select dates to visualize.",
                                          start = "2017-03-01", end = "2017-03-31",
                                          min = min(permits$permitdate), max = max(permits$permitdate))
                       )
                )
              )),
      tabItem(tabName = "about",
              fluidRow(
                column(width = 6,
                       box(width = NULL,
                           includeMarkdown("about.md")))
              )
      )
    )
  )
)