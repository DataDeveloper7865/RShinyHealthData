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
          
          ###User Selects Years
          checkboxGroupInput(inputId = "year", label = "select year to view", choices = unique(sort(myData$Year))),
          
        
          ###User Selects A Disease
          checkboxGroupInput(inputId = "disease", label = "select disease to view", choices = unique(sort(myData$Cause.Name))),
          
          ###User Selects A State
          checkboxGroupInput(inputId = "state", label = "select state to view", choices = unique(sort(myData$State)))
        
          ),
  
        
        #main panel for displaying outputs
        mainPanel(
          
          ####add output functions here
          plotOutput(outputId = "DeathsHisto"),
          textOutput(outputId = "YearsSelected"),
          textOutput(outputId = "DiseaseSelected"),
          textOutput(outputId = "StateSelected")
          
        )
      )
    )
  

### 1)if building an output object, save that output object to output$ ....... eg. output$hist
### 2)build objects to display with render*()   eg... renderPlot(), etc.
### 3)Use input values with input$ eg.... input$molecules
server <- function(input, output) {

    output$DeathsHisto <- renderPlot({ 
      
      plot(myData$Deaths[myData$Year == input$year & myData$State == input$state], c(1:as.integer(count(myData$Deaths[myData$Year == input$year & myData$State == input$state]))),
           main = input$year,
           ylab = "# of deaths",
           xlab = "Year")
      
    })
  
    
    output$YearsSelected <- renderText({
        input$year
      })
    
    output$DiseaseSelected <- renderText({
      input$disease
      })
    
    output$StateSelected <- renderText({
      input$state
      })

}

shinyApp(ui, server)