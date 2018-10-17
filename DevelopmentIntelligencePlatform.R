library(shiny)
library(dplyr)


##insert data file here
myData <- read.csv("C:/Users/Stephen/Desktop/R Projects/practice datasets/NCHS_-_Leading_Causes_of_Death__United_States.csv", header = T)

#Define UI for app that draws a histogram
 ui <- fluidPage(
                
    titlePanel("Health Data"),
             
      sidebarLayout(
        
        sidebarPanel(
          ###add input functions here
          checkboxGroupInput(inputId = "year", label = "select year to view", choices = unique(sort(myData$Year)))
          
          ),
  
        
        #main panel for displaying outputs
        mainPanel(
          
          ####add output functions here
          #plotOutput(outputId = "DeathsHisto"),
          textOutput(outputId = "YearsSelected")
        )
      )
    )
  

### 1)if building an output object, save that output object to output$ ....... eg. output$hist
### 2)build objects to display with render*()   eg... renderPlot(), etc.
### 3)Use input values with input$ eg.... input$molecules
server <- function(input, output) {

    #output$DeathsHisto <- renderPlot({ 
      
      #hist(myData$Deaths)
      
    #})
  
    
    output$YearsSelected <- renderText({
        input$year
      })

}

shinyApp(ui, server)