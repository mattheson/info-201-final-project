#Author: Javid Nuriyev
library("ggplot2")
library("dplyr")
library("tidyverse")

data <- read.csv("/Users/javidnuriyev/Downloads/info-201-final-project-main/info-201-final-project/data/Life Expectancy Data.csv")

library(tidyverse)
library(ggplot2)

data <- read.csv("../data/Life Expectancy Data.csv") %>%
  group_by(Country) %>%
  filter(!is.na(Life.expectancy)) %>%
  summarise(Country, Status, avg=mean(Life.expectancy)) %>%
  slice_head() %>%
  arrange(desc(avg))

plot <- ggplot(data, aes(x=reorder(Country, avg), y=avg, fill=Status)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme(axis.title.y=element_text(), axis.text.y=element_blank()) +
  scale_y_discrete("Average life expectancy (mean)") +
  scale_x_discrete("Country")

print(plot)