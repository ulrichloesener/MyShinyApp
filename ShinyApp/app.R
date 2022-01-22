library(shiny)
library(ggplot2)

load("bmi.rda")

ui <- fluidPage("COMPARE YOUR BMI", sliderInput(
                inputId = "slider", label = "What is your weight in kg?", value=100, min=30, max=200), 
                                sliderInput(
                inputId = "slider2", label = "What is your height in cm?", value = 160, min = 140, max=220), 
                plotOutput("hist"), textOutput("yourbmi"))

server <- function(input, output) {
  output$yourbmi <- renderText({paste0("Your BMI is ", input$slider / (input$slider2 * input$slider2) * 10000)})
  output$hist <- renderPlot({
    ggplot(data=bmi, aes(bmi)) + 
      geom_histogram(fill="lightblue") + 
      theme_minimal() +
      labs(title="BMI data from 500 People", subtitle="Red dotted line indicates the mean BMI") + 
      geom_vline(aes(xintercept=mean(bmi)), color="red", size=1, linetype="dashed") + 
      geom_vline(aes(xintercept=input$slider / (input$slider2 * input$slider2) * 10000), size=1)
    })
  
}

shinyApp(ui = ui, server = server)






