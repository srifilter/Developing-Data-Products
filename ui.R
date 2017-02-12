#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(dplyr)
library(leaflet)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Pollution Data by location in US"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("slider1",
                   "State Code",
                   min = 1,
                   max = 56,
                   value = 1)
    ),
   radioButtons("poll","Pollutants", c("Ozone"="Ozone","Carbon monoxide"="Carbon monoxide", "Acetone"="Acetone", "Methane"="Methane", "Isobutane"="Isobutane", "PM10"= "PM10 Total 0-10um STP",
                                       "Sulfur dioxide" = "Sulfur dioxide",   "Pb"="Lead (TSP) LC", "Chromium"="Chromium PM2.5 LC", "Phosphorus"="Phosphorus PM2.5 LC", "Nitrogen dioxide"="Nitrogen dioxide (NO2)", 
                                       "Radiation"="Solar radiation", "Arsenic"="Arsenic PM2.5 LC", "Zinc"="Zinc PM2.5 LC"))),
      
    # Show a plot of the generated distribution
    mainPanel(tabsetPanel(
       tabPanel('State',  textOutput("text2"),
                leafletOutput("map",width="80%",height="400px")
      
       ),
       tabPanel('Observation Count',textOutput("text3"),plotOutput("plot2"))
      )
    )
  )
)
