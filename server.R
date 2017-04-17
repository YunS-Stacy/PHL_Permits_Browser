
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)
library(lubridate)

shinyServer(function(input, output, session) {
  filtered_permits <- reactive({
    input$date1
    
    isolate({
      permits %>%
        filter(permitdate >= input$date1[1]) %>%
        filter(permitdate <= input$date1[2])
    })
  })
  
  observe({
    input$date1
    
    updateDateRangeInput(session, "date2",
                         "Select dates to visualize.",
                         start = input$date1[1],
                         end = input$date1[2],
                         min = min(permits$permitdate), max = max(permits$permitdate))
  })
  
  observe({
    input$date2
    
    updateDateRangeInput(session, "date1",
                         "Select dates to visualize.",
                         start = input$date2[1],
                         end = input$date2[2],
                         min = min(permits$permitdate), max = max(permits$permitdate))
  })
  
  output$permits_map <- renderLeaflet({
    filtered_permits() %>%
      leaflet() %>%
      setView(lng = "-75.165222", lat = "39.952583", zoom = 12) %>%
      addTiles() %>%
      addMarkers(clusterOptions = markerClusterOptions(),
                 popup = ~content)
  })
  
  output$daily_plot <- renderPlot({
    daily_permits <- filtered_permits() %>%
      group_by(permitdate) %>%
      summarize(permits_per_day = n())
    
    ggplot(daily_permits, aes(permitdate, permits_per_day)) + geom_line() + labs( x='Permit Date', y='Permit Issued Per Day')
  })
  
  output$desc_plot <- renderPlot({
    desc_permits <- filtered_permits() %>%
      group_by(permitdescription) %>%
      summarize(Total = n())
    
    ggplot(desc_permits, aes(permitdescription, Total)) + geom_bar(stat = "identity") + coord_flip() + labs(x='Permit Description')
    
  })
  
  output$total_permits <- renderText({
    as.character(nrow(filtered_permits()))
  })
  
  output$common_permits <- renderText({
    names(tail(sort(table(filtered_permits()$permitdescription)), 1))
  })
  
  output$weekday_permits <- renderText({
    names(tail(sort(table(wday(filtered_permits()$permitdate, label = TRUE, abbr = FALSE))), 1))
  })
  
})

