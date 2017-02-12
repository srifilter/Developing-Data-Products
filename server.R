#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plyr)
library(leaflet)
library(ggplot2)

dat_poll = read.csv("annual_all_2016.csv")
states <- cbind(unique(as.character(dat_poll$State.Name)), unique(as.numeric(dat_poll$State.Code)))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  dat<- reactive({
    dat1<- subset(dat_poll, dat_poll$Parameter.Name == input$poll)
    dat1 <- subset(dat1, dat1$State.Code == as.numeric(input$slider1))
    return(dat1)
    })
  
  output$text2 <- renderText(paste0("Pollution of ", input$poll, " in the State of  ",   states[states[,2]== input$slider1][1] ))
  output$map <- renderLeaflet(
    { dat2<- dat()
      dat2 %>% leaflet() %>% 
        addTiles()%>% addCircleMarkers(weight =1, color="Red", radius=dat2$Observation.Percent/5,clusterOptions = markerClusterOptions())
    })
  output$text3 <- renderText(paste0("Pollution levles in different Counties of ", states[states[,2]== input$slider1][1]))
  output$plot2<- renderPlot({
  dat3<- dat()
  dat4<- ddply(dat3,.(County.Name), summarize, tot=sum(Observation.Count), na.omit=TRUE)
  barplot(dat4$tot, names.arg=dat4$County.Name, xlab=paste0("County Names in the state of ", states[states[,2]== input$slider1][1]), ylab= " Pollution Count")
  })
  })
