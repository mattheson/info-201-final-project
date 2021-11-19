#Author: Ryan Oh
library("ggplot2")
library("tidyverse")

data <- read.csv("/Users/ryanoh/Desktop/info201/info-201-final-project/data/Life Expectancy Data.csv")
infant_deaths_per_year <- aggregate(data[6], list(data$Year), mean, na.rm = "TRUE")
View(infant_deaths_per_year)
infant_scatterplot <- ggplot(data = infant_deaths_per_year) +
  geom_point(mapping = aes(x = Group.1, y = infant.death)) +
  xlab("Year") + ylab("Average Infant Deaths")


# A good look at the infant deaths by the year can help us draw connections
# to overall societal conditions The infant death rate can reveal whether or 
# not our world as a whole is healthy. We can then use this to connect years 
# where morality rates maybe to high to reasoning that the world was affected
# by a variable which impacted global health.

# From the chart, we can deduce that the trend of infant death rates goes down 
# as the years increase. This shows us that the global health is improving, but
# this data set does not inlclude COVID affected years, which will be interesting
# to see going forward as there was a global health crisis.