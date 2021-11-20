#Author: Javid Nuriyev
library("tidyverse")
library("ggplot2")

data <- read.csv("../data/Life Expectancy Data.csv") %>%
  group_by(Country) %>%
  filter(!is.na(Life.expectancy)) %>%
  summarise(Country, Status, avg=mean(Life.expectancy)) %>%
  slice_head() %>%
  arrange(desc(avg))

life_expectancy_gdp <- ggplot(data, aes(x=reorder(Country, avg), y=avg, fill=Status)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme(axis.title.y=element_text(), axis.text.y=element_blank()) +
  ylab("Average life expectancy from 2000-2015 (mean)") +
  xlab("Countries")

print(life_expectancy_gdp)

# This plot shows average life expectancy of each country dividing them by 
# developed and developing countries. We can observe that developing countries 
# have lower life expectancy than developed countries. It gives us an 
# understanding that life expectancy is depend on country’s status. 
# After this point, we can further explore what variables affect country’s status,
# and find a relationship between those variables and life expectancy.
