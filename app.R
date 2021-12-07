library(shiny)
library(tidyverse)
library(readxl)

expectancy_data <- read.csv("./data/Life Expectancy Data.csv")
mortality_data <- read_excel("./data/Mortality-rate-among-children-and-you-age-5-to-24_2020.xlsx")
causes_data <- read.csv("./data/NCHS_-_Leading_Causes_of_Death__United_States.csv")


ui <- navbarPage("Title",
  tabPanel("Introduction",
           p("In this project, we were focused on analyzing ...")),
  tabPanel("Page 1",),
  tabPanel("Page 2"),
  tabPanel("Page 3"),
  tabPanel("Conclusion",
           p("From analyzing our results, we can see that ..."))
)

server <- function(input, output) {
  # output$page1 <-
  # output$page2 <-
  # output$page3 <-
}

shinyApp(ui, server)