# Calculations for summary information
# Results are stored in `summary_info`
# Author: Matt

library(tidyverse)
data <- read.csv("../data/Life Expectancy Data.csv")
summary_info <- list()

# `num_observations` - number of observations (rows)
summary_info$num_observations <- nrow(data)

# `num_features` - number of features (columns)
summary_info$num_features <- ncol(data)

# `oldest_year` - oldest year contained in an observation
summary_info$oldest_year <- data %>%
  slice_min(Year, with_ties=F) %>%
  pull(Year)

# `latest_year` - latest year contained in an observation
summary_info$latest_year <- data %>%
  slice_max(Year, with_ties=F) %>%
  pull(Year)

# `num_developing` - number of developing countries observed
summary_info$num_developing <- data %>%
  filter(Status == "Developing") %>%
  pull(Country) %>%
  n_distinct()

# `num_developed` - number of developing countries observed
summary_info$num_developed <- data %>%
  filter(Status == "Developed") %>%
  pull(Country) %>%
  n_distinct()

# `num_developing_obs` - number of observations of developing countries
summary_info$num_developing_obs <- data %>%
  filter(Status == "Developing") %>% nrow()

# `num_developed_obs` - number of observations of developed countries
summary_info$num_developed_obs <- data %>%
  filter(Status == "Developed") %>% nrow()

# `lowest_developing` - lowest life expectancy in developing countries
summary_info$lowest_developing <- data %>%
  filter(Status == "Developing") %>%
  slice_min(Life.expectancy, with_ties=F) %>%
  pull(Life.expectancy)

# `highest_developing` - highest life expectancy in developing countries
summary_info$highest_developing <- data %>%
  filter(Status == "Developing") %>%
  slice_max(Life.expectancy, with_ties=F) %>%
  pull(Life.expectancy)

# `lowest_developed` - lowest life expectancy in developed countries
summary_info$lowest_developed <- data %>%
  filter(Status == "Developed") %>%
  slice_min(Life.expectancy, with_ties=F) %>%
  pull(Life.expectancy)

# `highest_developed` - highest life expectancy in developed countries
summary_info$highest_developed <- data %>%
  filter(Status == "Developed") %>%
  slice_max(Life.expectancy, with_ties=F) %>%
  pull(Life.expectancy)
