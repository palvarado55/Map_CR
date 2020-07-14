
#library(shinydashboard)
#library(shinyBS)
#library(RColorBrewer)
#library(dplyr)
#library(ggplot2)
#library(rgdal)
library(shiny)
library(leaflet)
library(googleVis)

ui <- fluidPage( 
  
  column(4, offset = 8, leafletOutput("CostaRica")) ,
  
  leafletOutput("Centro")
               )

shinyServer <- function(input, output, session) {

  load("gadf.Rdata") # Archivo con la información, debe "residir" en el directorio base.
  
  lg = -84.10  # longitud   E(+), O(-)
  lt =   9.93  # latitud    N(+), S(-)
  zm =   7.4   # zoom
  
  output$CostaRica <- renderLeaflet({
    
    leaflet(gadf)                             %>% 
    addCircles(lng = lg, lat = lt)            %>% 
    addTiles()                                %>% 
    setView(   lng = lg, lat = lt, zoom = zm)   
    })

  output$Centro <- renderLeaflet({
    
    leaflet(gadf)                             %>% 
      addCircles(lng = 0, lat = 0)            %>% 
      addTiles()                              %>% 
      setView(   lng = 0, lat = 0, zoom = 5)   
  })
  
  }

shinyApp(ui = ui, server = shinyServer)
