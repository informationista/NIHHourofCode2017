#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(colourpicker)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Happy Hour of Code 2017!"),
   helpText("This app is a demo using the R DNase data to demonstrate some of the functionality of Shiny for the NIH 2017 Hour of Code."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         numericInput("Run",
                     "Select run number:",
                     min = 1,
                     max = 11,
                     value = 1),
         sliderInput("size", "Select the point size", 
                     min = 1,
                     max = 15, 
                     value = 1),
         selectInput("color", "Select the point color", c("purple", "red", "green", "blue")),
         textInput("title", "Create a title:")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("scatterPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$scatterPlot <- renderPlot({
     library(ggplot2) 
     # create the subset of the data based on the run we selected
      x    <- subset(DNase, Run == input$Run)
     # draw the histogram with the specified number of bins
      ggplot(data = x, aes(x = conc, y = density)) + geom_point(size = input$size, color = input$color) + ggtitle(input$title)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

