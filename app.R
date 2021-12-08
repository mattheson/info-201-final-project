library(shiny)
library(tidyverse)
library(ggplot2)
library(maps)
library(mapproj)

expectancy_data <- read.csv("./data/Life Expectancy Data.csv")
# mortality_data <- read_excel("./data/Mortality-rate-among-children-and-you-age-5-to-24_2020.xlsx")
causes_data <-
  read.csv("./data/NCHS_-_Leading_Causes_of_Death__United_States.csv")

# World plot
mapdata <- map_data("world")
world_plot_data <- rename(expectancy_data, "region" = "Country")
mapdata_joined <- left_join(mapdata, world_plot_data, by = "region")
filter_mapdata <-
  mapdata_joined %>% filter(!is.na(mapdata_joined$Life.expectancy))

ui <- navbarPage(
  "Info 201 Final Project",
  tabPanel(
    "Introduction",
    h1("Analysis of Mortality-Related Factors in the U.S. and Worldwide"),
    em(h3("Group: (Ryan, Javid, Jacob, Matt)")),
    img(
      src = "http://med.stanford.edu/content/dam/sm-news/images/2015/05/surgery-developing-world-msf.jpg",
      width = "50%",
      height = "50%",
      align = "right"
    ),
    p(
      "In this project, we were focused on analyzing and discovering factors
             related to life expectancy and mortality in the U.S. and other countries.
             Our first dataset is a life expectancy dataset from the WHO, containing
             information about expectancies in different countries between the years
             2000 to 2015. Our second dataset is from the CDC and contains data about
             causes of death throughout the United States."
    ),
    p("Three questions that we are aiming to answer were: "),
    em(strong(
      p(
        "What does the global life expectancy look like over the past 20~ years?"
      )
    )),
    em(strong(
      p(
        "What were the leading causes of death in America over the past 20~ years?"
      )
    )),
    em(strong(
      p(
        "How do different factors affect life expectancy between two comparing countries?"
      )
    ))
  ),
  tabPanel(
    "Page 1",
    h1("Life Expectancy Worldwide by Year"),
    sliderInput(
      "expectancy_year",
      label = "Select year",
      min = 2000,
      max = 2015,
      value = 2015,
      sep = "",
      ticks = F
    ),
    plotOutput("worldplot")
  ),
  tabPanel(
    "Page 2",
    h1("Causes of Deaths by Year in the USA"),
    sliderInput(
      "causes_year",
      label = "Select year",
      min = 1999,
      max = 2017,
      value = 2017,
      sep = "",
      ticks = F
    ),
    tableOutput("death_causes")
  ),
  tabPanel(
    "Page 3",
    selectInput(
      inputId = "country1",
      label = "First country (blue):",
      choices = unique(expectancy_data$Country)
    ),
    selectInput(
      inputId = "country2",
      label = "Second country (red):",
      choices = unique(expectancy_data$Country)
    ),
    radioButtons(
      inputId = "value",
      label = "Variable to plot:",
      c("Life Expectancy" = "Life.expectancy",
        "Adult Mortality (percent of dying between 15 and 60 yrs old, per 1000 people)" = "Adult.Mortality",
        "Infant Deaths (deaths per 1000 people)"   = "infant.deaths",
        "Alcohol Consumption (consumption of litres of pure alcohol for ages 15+)" = "Alcohol",
        "GDP (USD)"             =     "GDP",
        "Population"      =     "Population",
        "Schooling (average total years of schooling)" = "Schooling"
        )
    ),
    plotOutput("country_comparison")
    
  ),
  tabPanel("Conclusion",
           p(
             "From analyzing our results, we can see that ..."
           )),
           p("Key Takeaway 1"),
           p("Although many would expect the global life expectancy to raise over the past 20~ years, the map and slider show us that it isn’t the case. Many countries either keep the same life expectancy, or worse decrease. Some notable diffrences from 2000 to 2015 are Canada and Australia’s life expectancies. As developed countries, it is an interesting observation to see that their color goes from blue to purple (life expectancy equivalent of 90 to 80)."),
           p("Key Takeaway 2"),
           p("The number of deaths in the USA has increased over the last 20 years partly because of an increasing population, but there are key insights that the trends of the chart shows. First, we the USA still deals with medical advancement towards curing Alzheimers and cancer, which are both large contributors towards death in America. Another key observation is the rapid increase in suicide deaths from 1999 - 2017, which can be attributed to an increase in mental health struggle across this country’s population. ")
)

server <- function(input, output) {
  output$worldplot <- renderPlot(
    ggplot(
      filter(filter_mapdata, Year == input$expectancy_year),
      aes(x = long, y = lat, group = group)
    ) +
      geom_polygon(aes(fill = Life.expectancy), color = "black") +
      scale_fill_gradient(
        name = "Average Life Expectancy",
        low = "yellow",
        high = "blue",
        na.value = "grey50"
      ) +
      theme(
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        rect = element_blank()
      ) + coord_map(xlim = c(-180, 180))
  )
  
  output$death_causes <- renderTable(
    causes_data %>%
      filter(!(
        is.na(Year) || is.na(Deaths) || is.na(Cause.Name)
      ),
      Year == input$causes_year) %>%
      group_by(Cause.Name) %>%
      summarise(deaths = sum(as.numeric(
        str_replace_all(Deaths, ",", "")
      ))) %>%
      rename("Cause" = Cause.Name, "Number of Deaths" = deaths)
  )
  
  output$country_comparison <- renderPlot(
    ggplot() +
      geom_line(
        data = expectancy_data %>%
          filter(Country == input$country1) %>%
          select(Year,input$value),
        aes(x = Year, y = eval(parse(text=input$value))),
        color = "blue"
      ) +
      geom_line(
        data = expectancy_data %>%
          filter(Country == input$country2) %>%
          select(Year, input$value),
        aes(x = Year, y = eval(parse(text=input$value))),
        color = "red"
      ) + ylab("")
  )
  
}

shinyApp(ui, server)