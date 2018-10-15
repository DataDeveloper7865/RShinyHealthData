library(shiny)


##insert data file here
myData <- read.csv("C:/Users/Stephen/Desktop/R Projects/practice datasets/breslow.csv", header = T)


ui <- 
  fluidPage("Development Intelligence Platform",
    tabPanel("icIEF Data",
      sidebarLayout(
        sidebarPanel(
      ###add input functions here
        checkboxGroupInput(inputId = "molecules", label = "select molecules to view", choices = myData$Mol)),
  
        mainPanel(
        ####add output functions here
          plotOutput(outputId = "boxplotIEF"),
          textOutput(outputId = "text")
        )
      )
    ),
    tabPanel("Summary",
      verbatimTextOutput("summary")
    )
  )





### 1)if building an output object, save that output object to output$ ....... eg. output$hist
### 2)build objects to display with render*()   eg... renderPlot(), etc.
### 3)Use input values with input$ eg.... input$molecules
server <- function(input, output) {

    output$boxplotIEF <- renderPlot({ 
      ggplot(myData, aes(myData$icIEFtype, myData$icIEF)) +
        geom_boxplot() +
        geom_jitter(aes(myData$icIEFtype, myData$icIEF),
                    position = position_jitter(width = 0.1, height = 0),
                    alpha = 0.6,
                    size = 3,
                    show.legend = FALSE
        ) +
        xlab("Type of Species") +
        ylab("Relative % of Species")+
        title("icIEF Data for Historical Development Molecules")
      
      
      ##     boxplot(myData$acidic1year, 
 ##             myData$Main1year, 
 ##             myData$basic.1year,
 ##             data = myData,
 ##             names = c("Acidic", 
 ##                      "Main", 
  ##                      "Basic"),
  ##            col = c("grey50", 
   ##                   "grey50",
  ##                    "grey50"),
 ##             ylab = "% Relative Species",
  ##            main = "Acidics at 1 Year")
 ##     stripchart(myData$acidic1year[myData$Mol==input$molecules], 
  ##               myData$Main1year[myData$Mol==input$molecules], 
  ##               myData$basic.1year[myData$Mol==input$molecules],
  ##               vertical = TRUE, data = myData, method = "jitter", add = TRUE, pch = 20, col = "blue")
      
    })
    
    output$summary <- renderPrint({
      summary(myData)
    })
    
    output$text <- renderText({
        input$molecules
      })

}

shinyApp(ui, server)