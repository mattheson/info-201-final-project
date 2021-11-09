# A2: U.S. COVID Trends

## Overview
In many ways, we have come to understand the gravity and trends in the COVID-19 pandemic through quantitative means. Regardless of media source, people are consuming more epidemiological information than ever, primarily through reported figures, charts, and maps.

This assignment is your opportunity to work directly with the same data used by the New York Times. While the analysis is guided through a series of questions, it is your opportunity to use programming skills to ask more detailed questions about the pandemic.

You'll load the data directly from the [New York Times GitHub page](https://github.com/nytimes/covid-19-data/), and you should make sure to read through their documentation to understand the meaning of the datasets.

Note, this is a long assignment, meant to be completed over the two weeks when we'll be learning data wrangling skills. I strongly suggest that you **start early**, and approach it with patience. We're asking real questions of real data, and there is inherent trickiness involved.

## Analysis
You should start this assignment by opening up your `analysis.R` script. The script will guide you through an initial analysis of the data. Throughout the script, there are prompts labeled **Reflection**. Please write 1 - 2 sentences for each of these reflections below:

- What does each row in the data represent (hint: read the [documentation](https://github.com/nytimes/covid-19-data/)!)?
  - National: each row represents COVID-19 cases and deaths in terms of that particular day starting from 2020-01-21, the date when virus started spreading.

- What did you learn about the dataset when you calculated the state with the lowest cases (and what does that tell you about testing your assumptions in a dataset)?
  -  There were places which are assigned as states, however they are not states in real life. Due to the small territory, they had the lowest cases. I eliminated them by making research related fips codes.
  - Assumption: dataset contains states that is not considered a state by the US government.

- Is the location with the highest number of cases the location with the most deaths? If not, why do you believe that may be the case?
  - It is different. It could be due to many factors such as healthcare system, income rate, racial injustice in a region with highest death rate.

- What do the plots of cases and deaths tell us about the  pandemic happening in "waves"? How (and why, do you think) these plots look so different?
  - Have not covered plots.

- Why are there so many observations (counties) in the variable `lowest_in_each_state` (i.e., wouldn't you expect the number to be ~50)?
  - Alaska has many counties in it and due to the small population COVID-19 was not spread there that is why it has 0 death rate in 26 counties.

- What surprised you the most throughout your analysis?
  - It surprised me to see that there are outliers in the dataset which could affect the whole calculation process.
  - Also only small counties which less population have zero new covid-19 cases.
