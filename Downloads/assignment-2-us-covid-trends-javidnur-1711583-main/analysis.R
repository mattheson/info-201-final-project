# Overview ----------------------------------------------------------------

# Assignment 2: U.S. COVID Trends
# For each question/prompt, write the necessary code to calculate the answer.
# For grading, it's important that you store your answers in the variable names
# listed with each question in `backtics`. Please make sure to store the
# appropriate variable type (e.g., a string, a vector, a dataframe, etc.)
# For each prompt marked `Reflection`, please write a response
# in your `README.md` file.


# Loading data ------------------------------------------------------------

# You'll load data at the national, state, and county level. As you move through
# the assignment, you'll need to consider the appropriate data to answer
# each question (though feel free to ask if it's unclear!)

# Load the tidyverse package
#install.packages("tidyverse")
library("tidyr")
library("stringr")
library("dplyr")         

# Load the *national level* data into a variable. `national`
# (hint: you'll need to get the "raw" URL from the NYT GitHub page)
national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv")
View(national)
# Load the *state level* data into a variable. `states`
states <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

# Load the *county level* data into a variable. `counties`
# (this is a large dataset, which may take ~30 seconds to load)
counties <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

# How many observations (rows) are in each dataset?
# Create `obs_national`, `obs_states`, `obs_counties`
obs_national <- nrow(national) #657

obs_states <- nrow(states) #33886

obs_counties <- nrow(counties) #1894595

# Reflection: What does each row represent in each dataset?


# How many features (columns) are there in each dataset?
# Create `num_features_national`, `num_features_states`, `num_features_counties`
num_features_national <- ncol(national) #3

num_features_states <-  ncol(states) #5

num_features_counties <- ncol(counties) #6

# Exploratory analysis ----------------------------------------------------

# For this section, you should explore the dataset by answering the following
# questions. HINT: Remeber that in class, we talked about how you can answer 
# most data analytics questions by selecting specific columns and rows. 
# For this assignemnt, you are welcome to use either base R dataframe indexing or
# use functions from the DPLYR package (e.g., using `pull()`). Regardless, you 
# must return the specific column being asked about. For example, if you are 
# asked the *county* with the highest number of deaths, your answer should
# be a single value (the name of the county: *not* an entire row of data).
# (again, make sure to read the documentation to understand the meaning of
# each row -- it isn't immediately apparent!)

# How many total cases have there been in the U.S. by the most recent date
# in the dataset? `total_us_cases`
max_date_national <- filter(national, date == max(date))
total_us_cases <- select(max_date_national, cases) 
total_us_cases #46449331

# How many total deaths have there been in the U.S. by the most recent date
# in the dataset? `total_us_deaths`
total_us_deaths <- select(max_date_national, deaths)
total_us_deaths #754051

# Which state has had the highest number of cases?
# `state_highest_cases`
state_highest_cases_row <- filter(states, cases == max(cases))
state_highest_cases <- select(state_highest_cases_row, state) 
state_highest_cases #California

# What is the highest number of cases in a state?
# `num_highest_state`
state_highest_state <- select(state_highest_cases_row, cases) 
state_highest_state #4961782

# Which state has the highest ratio of deaths to cases (deaths/cases), as of the
# most recent date? `state_highest_ratio`
# (hint: you may need to create a new column in order to do this!)
states_df <- mutate(states, deaths_cases_ratio = deaths / cases)

max_date_states <- filter(states_df, date == max(date))

max_date_states_row <- filter(max_date_states, deaths_cases_ratio == max(deaths_cases_ratio))
state_highest_ratio <- select(max_date_states_row, state)
state_highest_ratio #New Jersey

# Which state has had the lowest number of cases *as of the most recent date*?
# (hint, this is a little trickier to calculate than the maximum because
# of the meaning of the row). `state_lowest_cases`
states_only_df <- filter(max_date_states, fips <= 56) #df eliminate places that are not state

state_lowest_cases_row <- filter(states_only_df, cases == min(cases))
state_lowest_cases <- select(state_lowest_cases_row, state) 
state_lowest_cases #Vermont

# Reflection: What did you learn about the dataset when you calculated
# the state with the lowest cases (and what does that tell you about
# testing your assumptions in a dataset)?

# Which county has had the highest number of cases?
# `county_highest_cases`
county_highest_cases_row <- filter(counties, cases == max(cases))
county_highest_cases <- select(county_highest_cases_row, county)
county_highest_cases #Los Angeles

# What is the highest number of cases that have happened in a single county?
# `num_highest_cases_county`
county_highest_cases <- select(county_highest_cases_row, cases) 
county_highest_cases #1503380

# Because there are multiple counties with the same name across states, it
# will be helpful to have a column that stores the county and state together
# (in the form "COUNTY, STATE").
# Add a new column to your `counties` data frame called `location`
# that stores the county and state (separated by a comma and space).
# You can do this by mutating a new column, or using the `unite()` function
# (just make sure to keep the original columns as well)
counties_df <- unite(counties, location, c(county, state), sep = ", " , na.rm = TRUE, remove = FALSE) 

# What is the name of the location (county, state) with the highest number
# of deaths? `location_most_deaths`
location_most_deaths <- counties_df %>% 
  drop_na(deaths) %>% 
  filter(deaths == max(deaths)) %>% 
  select(location)

location_most_deaths #New York City, New York

# Reflection: Is the location with the highest number of cases the location with
# the most deaths? If not, why do you believe that may be the case?


# At this point, you (hopefully) have realized that the `cases` column *is not*
# the number of _new_ cases in a day (if not, you may need to revisit your work)
# Add (mutate) a new column on your `national` data frame called `new_cases`
# that has the nubmer of *new* cases each day (hint: look for the `lag`
# function).
national_df <- mutate(national_df, new_cases = cases - lag(cases, default = 0))

# Similarly, the `deaths` columns *is not* the number of new deaths per day.
# Add (mutate) a new column on your `national` data frame called `new_deaths`
# that has the nubmer of *new* deaths each day
national_df <- mutate(national_df, new_deaths = deaths - lag(deaths, default = 0))

# What was the date when the most new cases occured?
# `date_most_cases`
date_most_cases_row <- filter(national_df, new_cases == max(new_cases))
date_most_cases <- select(date_most_cases_row, date)
date_most_cases #2021-09-07

# What was the date when the most new deaths occured?
# `date_most_deaths`
date_most_deaths_row <- filter(national_df, new_deaths == max(new_deaths))
date_most_deaths <- select(date_most_deaths_row, date)
date_most_deaths #2021-02-12

# How many people died on the date when the most deaths occured? `most_deaths`
most_deaths <- select(date_most_deaths_row, new_deaths)
most_deaths #5463

# Grouped analysis --------------------------------------------------------

# An incredible power of R is to perform the same computation *simultaneously*
# across groups of rows. The following questions rely on that capability.

# What is the county with the *current* (e.g., on the most recent date)
# highest number of cases in each state? Your answer, stored in
# `highest_in_each_state`, should be a *vector* of
# `location` names (the column with COUNTY, STATE).
# Hint: be careful about the order of filtering your data!
counties_df <- counties_df %>%
  group_by(county) %>%
  mutate(new_cases = cases - lag(cases, default = 0))

counties_df <- counties_df %>%
  group_by(county) %>%
  mutate(new_deaths = deaths - lag(deaths, default = 0))

highest_in_each_state <- counties_df %>%
  group_by(county) %>%
  group_by(state) %>%
  filter(date == max(date)) %>%
  filter(new_cases == max(new_cases)) %>%
  pull(location)

highest_in_each_state

# What is the county with the *current* (e.g., on the most recent date)
# lowest number of deaths in each state? Your answer, stored in
# `lowest_in_each_state`, should be a *vector* of
# `location` names (the column with COUNTY, STATE).
lowest_in_each_state <- counties_df %>%
  group_by(county) %>%
  group_by(state) %>%
  filter(date == max(date)) %>%
  filter(new_deaths == min(new_deaths)) %>%
  pull(location)

lowest_in_each_state

# Reflection: Why are there so many observations (counties) in the variable
# `lowest_in_each_state` (i.e., wouldn't you expect the number to be ~50)?

# The following is a check on our understanding of the data.
# Presumably, if we add up all of the cases on each day in the
# `states` or `counties` dataset, they should add up to the number at the
# `national` level. So, let's check.

# First, let's create `state_by_day` by adding up the cases on each day in the
# `states` dataframe. For clarity, let's call the column with the total cases
# `state_total`
# This will be a dataframe with the columns `date` and `state_total`.
states_df <- states_df %>%
  group_by(state) %>%
  mutate(new_cases = cases - lag(cases, default = 0))

states_df <- states_df %>%
  group_by(state) %>%
  mutate(new_deaths = deaths - lag(deaths, default = 0))

state_by_day <- states_df %>%
  group_by(date) %>%
  summarise(state_total = sum(new_cases)) %>%
  mutate(state_total = cumsum(state_total))


# Next, let's create `county_by_day` by adding up the cases on each day in the
# `counties` dataframe. For clarity, let's call the column with the total cases
# `county_total`
# This will also be a dataframe, with the columns `date` and `county_total`.
county_by_day <- counties_df %>%
  group_by(date) %>%
  summarise(county_total = sum(new_cases)) %>%
  mutate(county_total = cumsum(county_total))

# Now, there are a few ways to check if they are always equal. To start,
# let's *join* those two dataframes into one called `totals_by_day`
totals_by_day <- full_join(state_by_day, county_by_day, by = "date")

# Next, let's create a variable `all_totals` by joining `totals_by_day`
# to the `national` dataframe
all_totals <- full_join(totals_by_day, national_df, by = "date")

# How many rows are there where the state total *doesn't equal* the natinal
# cases reported? `num_state_diff`
num_state_diff <- sum(all_totals$state_total == all_totals$cases, na.rm = TRUE)
num_state_diff #645

# How many rows are there where the county total *doesn't equal* the natinal
# cases reported? `num_county_diff`
num_county_diff <- sum(all_totals$county_total == all_totals$cases, na.rm = TRUE)
num_county_diff #44


# Oh no! An inconsistency -- let's dig further into this. Let's see if we can
# find out *where* this inconsistency lies. Let's take the county level data,
# and add up all of the cases to the state level on each day (e.g.,
# aggregating to the state level). Store this dataframe with three columns
# (state, date, county_totals) in the variable `sum_county_to_state`.
# (To avoid DPLYR automatically grouping your results,
# specify `.groups = "drop"` in your `summarize()` statement. This is a bit of
# an odd behavior....)
sum_county_to_stat <- counties_df %>%
  group_by(state, date) %>%
  summarise(county_totals = sum(cases), .groups = "drop")

# Then, let's join together the `sum_county_to_state` dataframe with the
# `states` dataframe into the variable `joined_states`.
joined_states <- full_join(sum_county_to_stat, states_df, by = c("state", "date"))
View(joined_states)

# To find out where (and when) there is a discrepancy in the number of cases,
# create the variable `has_discrepancy`, which has *only* the observations
# where the sum of the county cases in each state and the state values are
# different. This will be a *dataframe*.
has_discrepancy <- joined_states %>%
  filter(county_totals != cases) 

# Next, lets find the *state* where there is the *highest absolute difference*
# between the sum of the county cases and the reported state cases.
# `state_highest_difference`.
# (hint: you may want to create a new column in `has_discrepancy` to do this.)
state_highest_difference <- has_discrepancy %>%
  mutate(difference = abs(county_totals - cases)) %>%
  filter(difference == max(difference)) %>%
  select(state)

state_highest_difference #Missouri

# Independent exploration -------------------------------------------------

# Ask your own 3 questions: in the section below, pose 3 questions,
# then use the appropriate code to answer them.

# *Question 1*: Was there any date where new cases was lower than new deaths?

# Answer: We can see that, on 2021-06-04, the number of new deaths was higher 
# than the number of new cases. It is uncommon because pandemic is still happening
# and the ratio of death per cases is much lower. Looking to the dataset closely,
# we can see that it might be an outlier in the dataset.
death_higher <- national_df %>%
  filter(new_deaths > new_cases) %>%
  select(date)

# *Question 2*: Which state does the first death happened?

# Answer: First COVID-19 death happened in Washington state on 2020-02-29
first_death <- states_df %>%
  filter(deaths == 1) %>%
  filter(date == min(date)) 
  
first_death_state <- first_death[1,]  %>%
  select(date, state)
  
# *Question 3*: List of locations where there are no new cases on recent date?

# Answer: From this question, I got the list of locations where there is no
# new COVID-19 cases. This is important because we can further look what is
# special in these locations that they ended up with no cases. However, looking
# at the results, we can see that it is mostly small areas which low population 
# size
no_new_case <- counties_df %>%
  group_by(county) %>%
  group_by(state) %>%
  filter(date == max(date)) %>%
  filter(new_cases == 0) %>%
  pull(location)

# Reflection: What surprised you the most throughout your analysis?
