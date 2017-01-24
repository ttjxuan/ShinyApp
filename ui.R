#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Welcome to Statistic Field, Show Time!"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
         h3("Explore tabst>_<"),
         h5("Tab1 first"),

         numericInput("obs1", "Enter Tab 1 integer -10 to 10", min = -10, max = 10, value = 2, step = 1),
         
         h5("Tab2 Now"),
         textInput("box2", "Decide Tab 2 Plot Title:", value = "My Plot!"),
         
         sliderInput("sliderX", "Pick Minimum and Maximum X Values",
                     -100, 100, value = c(-50, 50)),
         sliderInput("sliderY", "Pick Minimum and Maximum Y Values",
                     -100, 100, value = c(-50, 50)),
         checkboxInput("show_title", "Show/Hide Title",value = TRUE),
         
         h5("Tab3 Next"),
         sliderInput("sliderSpd", "What is the Speed of the car?", 4.0, 25.0, value = 15.0),
         checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
         checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
         checkboxInput("showModel3", "Show/Hide Model 3", value = TRUE),
         submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
         h3("Hit the Submit at the bottom of the sidebar and See your result"),
         
        
         tabsetPanel(type = "tabs", 
                     tabPanel("Documentation", br(), 
                              h3("Do you know How to use this app?"),
                              
                              h5("Notice that all the changes you make won't work until you hit the submit 
                                 at the end of the sidebar"),
                              h5("The datasets used: in tab1, we use mtcars in library(MASS), tab3 we 
                                 use cars in library(datasets),contains speed and cars. tab 2 is simulated 
                                 data by using normal distribution"),
                              h5("Tab1 is using plotly, you can set a number at sidebar and you will get the 
                                 points layout at the right by hitting submit buttom. As the number you put in goes
                                 higher, the graph moves to the left(means x value would be smaller)."),
                              h5("Tab2 contains the random data points, You can change the x and y limitation by 
                                 slide the sliders at the sidebar and hit the submit. Remember you can also choose 
                                 to hide or show the plot name by unclik/click on the left. The plot title could be 
                                 customized by users"),
                              h5("Tab3 contains the reactive plot, I use the speed and the distance to stop at this speed.
                                  there are three regression I fit by using speed as predictor and distance as outcome in cars 
                                  dataset.Purple one is simple linear regression,
                                  pink one is cutting the speed to two parts and fit the linear regression. The blue line is
                                  doing the polynomial regression. You can change the value of speed and will get the predicted
                                  value of each regression. Also, you are able to choose hide or show the model lines in the graph.
                                  "),
                              h5("all of the tabs have default values if you are not entering or changing."),
                              h5("Github repo contains code and more info: https://github.com/ttjxuan/ShinyApp"),
                              h5("Here is link for presentation: http://rpubs.com/ttjxuan/MyShinyAppPresentation"),
                              h3("Have fun!")
                              ),
                     
                     tabPanel("Tab1", br(), plotlyOutput("out1"),textOutput("out11"),
                              h4("Your number decide the weight, we have the formula taht wt-0.1*your number")), 
                     tabPanel("Tab2", br(), plotOutput("out2")), 
                     tabPanel("Tab3", br(), plotOutput("out3"),
                              h5("Predicted Distance from Model 1:"),
                              textOutput("pred1"),
                              h5("Predicted Distance from Model 2:"),
                              textOutput("pred2"),
                              h5("Predicted Distance from Model 3:"),
                              textOutput("pred3"))
                     
                     
    )
  )
))
)
