library(shiny)
library(ggplot2)

data_set <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

ui = fluidPage(
  tabsetPanel(
    tabPanel("Introduction",
             h1(strong("Introduction")),
             p("In this report, I will be taking a look at CO2 emissions. I will be highlighting the points of a few trends of CO2 use in our world. For example 
               we will be looking into the average of all CO2 use for each of the countries and the highest average. "),
             br(),
             p(strong("CO2 average among all countries:")),
             tableOutput("transfer"),
             br(),
             p(strong("CO2 highest average amoung all of the countries:")),
             tableOutput("changeUS"),
             br(),
             p(strong("CO2 average of the United States:")),
             textOutput("highest_average"),
             br(),
             p("Looking into all of these introduction states we can look into the United States as the highest representative in each of my categories. These 
               datasets should educate people that don't know what climate change can do to America. I wanted to emphasize the USA because I don't want our population to be in
               danger due to CO2 control."),
              ),
            
    tabPanel("Visualization",
             h2(strong("Bar chart of CO2 use of all countries")),
             plotlyOutput("visual"),
             br(),
             p("With this visualization, you get to customize which country to look for by choosing the countries that are given below the visualization, after using a color coordination
               feature I put in you will be able to choose a color to your liking and track the specific increases or decreases on the graph. You will learn about a specific country and how 
               they use their CO2 levels, with the Y axis being the amount of CO2 change and the X axis being the year."),
             selectInput(inputId="countryVarr", label="Select a Country", selected=first(data_set$country), choices = unique(data_set$country)),
             selectInput(inputId = "colorselect", label="Color", choices=list("Blue"="blue","Green"="green","Red"="red"), selected="Red")
             )
  )
)









