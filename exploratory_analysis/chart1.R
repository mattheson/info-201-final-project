# Author: Jacob Ye
library("ggplot2")
library("tidyverse")
library("ggforce")
data <- read.csv("../data/Life Expectancy Data.csv")
year <- aggregate(data[4],list(data$Year), mean, na.rm="TRUE")
expectancy_time_plot <- ggplot(year, aes(x=Group.1,y=Life.expectancy, group=1)) +
  geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("Life Expectancy")


# We included this chart to show how life expectancy has changed over the years.
# We think that it's important to see the general trend and see if it
# aligns of what we think how life expectancy should change, and We think that
# it does corroborate with our beliefs that as time passes on our health
# technology gets better.
