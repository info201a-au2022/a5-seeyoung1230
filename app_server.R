library(shiny)
library(ggplot2)
library(plotly)

data_set <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

server <- function(input, output) {
  
  ave_country <- data_set %>%
    select(c(3,8)) %>%
    filter(iso_code != "") %>%
    group_by(iso_code) %>%
    summarise(avg = sum(co2, na.rm = TRUE)) %>%
    filter(avg >= 117547.633)
  
  output$transfer <- renderTable({
# shows the average of all co2 for each country
  ave_country
})

    output$highest_average <- renderText({
      highest_average <- filter(ave_country, max(avg)==avg)
      highest_average <- paste("Average CO2 emissions of the USA:", highest_average[2]) 
    })
 
  output$changeUS <- renderTable({
    change_over_year <- data_set %>%
    group_by(iso_code) %>%
    arrange(year, .by_group = TRUE) %>%
    filter(iso_code == "USA") %>%
    mutate(change = (co2) - lag(co2)) %>%
    filter(year >= 2017)

    change_over_year <- change_over_year[-c(1,4:74)]
  })
  
  output$visual <- renderPlotly({
    selectedCountry <- input$countryVarr
    changed <- data_set %>%
      filter(country == selectedCountry) %>%
      filter(year >= 1960) %>%
      arrange(year, .by_group = TRUE) %>%
      mutate(change = (co2) - lag(co2)) 
    
    changed <- changed[c(1,2,75)]
    
    changer <- ggplot(data=changed, aes_string(x="year",y="change", fill="country")) +
      geom_line(stat="identity",color=input$colorselect) + theme(legend.position = "none")+geom_bar(stat="identity")+
      labs(title="Increase/Decrease of C02 Emissions")
    
    changer <- ggplotly(changer)
    changer
  })
}













  
  




