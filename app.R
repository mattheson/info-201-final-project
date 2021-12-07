library(shiny)
library(tidyverse)
library(readxl)

expectancy_data <- read.csv("./data/Life Expectancy Data.csv")
mortality_data <- read_excel("./data/Mortality-rate-among-children-and-you-age-5-to-24_2020.xlsx")
causes_data <- read.csv("./data/NCHS_-_Leading_Causes_of_Death__United_States.csv")


ui <- navbarPage("Title",
  tabPanel("Introduction"),
  tabPanel("Page 1"),
  tabPanel("Page 2"),
  tabPanel("Page 3"),
  tabPanel("Conclusion")
)

server <- function(input, output) {
}

shinyApp(ui, server)