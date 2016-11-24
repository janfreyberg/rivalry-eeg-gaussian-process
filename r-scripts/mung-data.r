library(dplyr)
library(tidyr)
library(ggplot2)

data <- read.csv('all-results.csv')

timedata <- data %>%
  # drop all nonrelevant data
  select(id, starts_with("timecourse")) %>%
  # reshape into columns
  gather(percepttime, probability, -id) %>%
  mutate(percept = as.factor(substring(percepttime, 11, nchar(percepttime)-3)),
         time = as.numeric(substring(percepttime, nchar(percepttime)-2)),
         id = as.character(id))

timedata.bynext <- data %>%
  select(id, starts_with("nextcourse")) %>%
  # reshape into columns
  gather(percepttime, probability, -id) %>%
  mutate(percept = as.factor(substring(percepttime, 11, nchar(percepttime)-3)),
         time = as.numeric(substring(percepttime, nchar(percepttime)-2)),
         id = as.character(id))