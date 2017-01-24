#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

shinyServer(function(input, output) {
   
  output$text <- renderText(input$slider1)
  output$out1 <- renderPlotly({
    plot_ly(x=mtcars$wt-0.1*input$obs1, y = mtcars$mpg, mode = "markers",color = as.factor(mtcars$cyl)) %>%
      layout(title = "Plotly graph")
})
  
  # Tab 2
  output$out2 <- renderPlot({
    minX <- input$sliderX[1]
    maxX <- input$sliderX[2]
    minY <- input$sliderY[1]
    maxY <- input$sliderY[2]
    dataX <- runif(1000, minX, maxX)
    dataY <- runif(1000, minY, maxY)
    main <- ifelse(input$show_title, input$box2, "")
    plot(dataX, dataY, xlab = "X Axis", ylab = "Y Axis", main = main,
         xlim = c(-100, 100), ylim = c(-100, 100), col = "dark green")
  })
  
  ### Tab3 
  
  cars$spd1 <- ifelse(cars$speed - 12 > 0, cars$speed - 12, 0)
  model1 <- lm(dist ~ speed, data = cars)
  # model2 <- lm(dist ~ speed + spd1, data = cars)
  model2 <- lm(dist ~ spd1, data = cars)
  model3 <- lm(dist ~ I(speed^3), data = cars)
  
  model1pred <- reactive({
    spdInput <- input$sliderSpd
    predict(model1, newdata = data.frame(speed = spdInput))
  })
  
  model2pred <- reactive({
    spdInput <- input$sliderSpd
    predict(model2, newdata = 
              data.frame(speed = spdInput,
                         spd1 = ifelse(spdInput - 12 > 0,
                                        spdInput - 12, 0)))
  })
  
  model3pred <- reactive({
    spdInput <- input$sliderSpd
    predict(model3, newdata = data.frame(speed = spdInput))
  })
  
  output$out3 <- renderPlot({
    spdInput <- input$sliderSpd
    
    plot(cars$speed, cars$dist, xlab = "Speed (mph)", 
         ylab = "Stopping distance (ft)", bty = "n", pch = 14,
         xlim = c(0, 30), ylim = c(1, 125))
    if(input$showModel1){
      abline(model1, col = "purple", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        speed = 4:25, spd1 = ifelse(4:25 - 12 > 0, 4:25 - 12, 0)
      ))
      lines(4:25, model2lines, col = "pink", lwd = 2)
    }
    if(input$showModel3){
      # model3lines <- predict(model3, newdata = data.frame(speed = spdInput))
      lines(cars$speed,fitted(model3), col = "blue", lwd = 2)
    }
    
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction","Model 3 Prediction"), pch = 16, 
           col = c("purple", "green","pink"), bty = "n", cex = 1.2)
    points(spdInput, model1pred(), col = "purple", pch = 16, cex = 2)
    points(spdInput, model2pred(), col = "pink", pch = 16, cex = 2)
    points(spdInput, model3pred(), col = "blue", pch = 16, cex = 2)
    
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  }) 
  
  output$pred3 <- renderText({
    model3pred()
  })
  
})
