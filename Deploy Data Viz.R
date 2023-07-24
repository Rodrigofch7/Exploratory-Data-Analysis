library(tseries)
library(readr)
library(tidyverse)
library(plotly)
library(shiny)

Link:
https://rodrigofrancac.shinyapps.io/DATA-VIZ/

df <- read_csv("my_dataframe.csv") 

hover_text <- paste("Country: ", df$Country, "<br>",
                    "Minimum wage: ", df$`Minimum wage`, "<br>",
                    "Unemployment rate: ", df$`Unemployment rate`, "<br>")

# Create the scatter map 1
fig <- plot_ly(df, type = "scattermapbox",
               lon = ~Longitude,
               lat = ~Latitude,
               color = ~`Minimum wage`,
               size = ~`Unemployment rate`,
               hoverinfo = "text",
               hovertext = hover_text,
               mode = "markers",
               source = "source") %>%
  layout(
    mapbox = list(
      style = "open-street-map",
      zoom = 0.1
    )
  ) %>%
  config(displayModeBar = FALSE) # Optional: Remove the mode bar for cleaner visualization


hover_text2 <- paste("Country: ", df$Country, "<br>",
                     "Physicians per thousand: ", df$`Physicians per thousand`, "<br>",
                     "Life expectancy: ", df$`Life expectancy`, "<br>")

# Create the scatter map 2
fig2 <- plot_ly(df, type = "scattermapbox",
                lon = ~Longitude,
                lat = ~Latitude,
                color = ~`Physicians per thousand`,
                size = ~`Life expectancy`,
                hoverinfo = "text",
                hovertext = hover_text2,
                mode = "markers",
                source = "source") %>%
  layout(
    mapbox = list(
      style = "open-street-map",
      zoom = 0.1
    )
  ) %>%
  config(displayModeBar = FALSE) # Optional: Remove the mode bar for cleaner visualization


#APP

ui <- fluidPage(
  navbarPage(
    "WORLD DATA",
    tabPanel(
      "Scatter Map 1",
      fluidPage(
        plotlyOutput("scatter")
      )
    ),
    tabPanel(
      "Scatter Map 2",
      fluidPage(
        plotlyOutput("scatter2")
      )
    )
  )
)

server <- function(input, output, session) {
  output$scatter <- renderPlotly({
    fig
  })
  
  output$scatter2 <- renderPlotly({
    fig2
  })
}

shinyApp(ui, server)
