# Aggregate table
# Each row is a single country with its expectancies averaged
# Author: Matt

library(dplyr)
data <- read.csv("../data/Life Expectancy Data.csv")

aggregate_table <- data %>%
  group_by(Country) %>%
  summarise(Country, Status, Average = round(mean(na.omit(Life.expectancy)), digits=1)) %>%
  slice_head() %>%
  arrange(desc(Average)) %>%
  filter(!is.nan(Average))
