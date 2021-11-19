library(ggplot2)
library(tidyverse)
data <- read.csv("~/info-201-final-project/data/Life Expectancy Data.csv")
year <- aggregate(data[4],list(data$Year), mean, na.rm="TRUE")
ggplot(year, aes(x=Group.1,y=Life.expectancy)) +
  geom_bar(stat="Identity", fill="steelblue") + 
  xlab("Year") + ylab("Life Expectancy")
