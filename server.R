library(shiny)
library(ggplot2)

function(input, output){
  output$scatter = renderPlot({ggplot(data=cfb, aes(x=cfb[,input$xSelection], y=cfb[,input$ySelection])) + geom_point(color=input$color) + 
      labs(x=input$xSelection, y=input$ySelection)})
  output$correlation = renderPrint({
    paste("Correlation Coefficient:", cor(cfb[,input$xSelection], cfb[,input$ySelection], use="complete.obs"))})
}