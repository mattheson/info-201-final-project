#Author: Javid Nuriyev
library("ggplot2")
library("dplyr")
library("gridExtra")

data <- read.csv("/Users/javidnuriyev/info-201-final-project/data/Life Expectancy Data.csv")

group_by_developed <- data %>%
  filter(Status == "Developed") %>%
  group_by(Year) %>%
  na.omit(Life.expectancy) %>%
  na.omit(GDP) %>%
  summarise(Life.expectancy = mean(Life.expectancy), GDP = mean(GDP) ) 

group_by_developing <- data %>%
  filter(Status == "Developing", Year < 2015) %>%
  group_by(Year) %>%
  na.omit(Life.expectancy) %>%
  na.omit(GDP) %>%
  summarise(Life.expectancy = mean(Life.expectancy), GDP = mean(GDP) )  

ggp1 <- ggplot(group_by_developed, aes(x = Year)) + 
  geom_line(mapping = aes(y = Life.expectancy), color = "blue") +
  geom_line(mapping = aes(y = group_by_developing$Life.expectancy), color = "red") +
  xlab("Year") + ylab("Life Expectancy") 

ggp2 <- ggplot(group_by_developed, aes(x = Year)) + 
  geom_line(mapping = aes(y = GDP), color = "blue") +
  geom_line(mapping = aes(y = group_by_developing$GDP), color = "red") +
  xlab("Year") + ylab("GDP")

ggp_sum <- grid.arrange(ggp1, ggp2)

plot(ggp_sum)

# This line graph shows the trends of life expectancy and
# GDP values between developing and developed countries. Looking to the chart, 
# we can observe that life expectancy and GDP is much higher for developed 
# countries in compare to developing ones. At the same time, the lines has the 
# similar trends of increase for developed countries, while it increases 
# insignificantly for developed countries. This graph tell us that there is a gap 
# between developing and developed countries in terms of life expectancy. Increasing 
# GDP rates might be correlated with life expectancy rateas they follow the similar
# trend.

