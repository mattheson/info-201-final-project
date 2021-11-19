# Aggregate table
# Each row is a single country with its expectancies averaged
# Author: Matt

library(dplyr)
data <- read.csv("../data/Life Expectancy Data.csv")

aggregate_table <- data %>%
  group_by(Status) %>%
  summarise(
    Status,
    avg_expectancy = round(mean(na.omit(Life.expectancy)), digits=1),
    avg_population = round(mean(na.omit(Population)), digits=1),
    avg_gdp = round(mean(na.omit(GDP))),
            ) %>%
  slice_head() %>%
  arrange(desc(avg_expectancy)) %>%
  filter(!is.nan(avg_expectancy))
