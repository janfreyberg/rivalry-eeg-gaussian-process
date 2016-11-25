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


timedata.mix.bynext <- data %>%
  select(id, starts_with("nextcourse")) %>%
  # reshape into columns
  gather(percepttime, probability, -id) %>%
  mutate(percept = as.factor(substring(percepttime, 11, nchar(percepttime)-3)),
         time = as.numeric(substring(percepttime, nchar(percepttime)-2)),
         id = as.character(id))


timedata.dominant.bynext <- data %>%
  select(id, starts_with("after")) %>%
  gather(currentnext, probability, -id) %>%
  # drop the leading after_
  mutate(currentnext = substring(currentnext, 6)) %>%
  # separate into the required columns
  separate(currentnext, c("current", "following", "time"), sep="_", convert=TRUE) %>%
  mutate(following = gsub("highfreq|lowfreq", "dominant", following))


averagedata.bypercept <- data %>%
  select(id, starts_with("mean")) %>%
  # reshape into columns
  gather(percept, probability, -id) %>%
  mutate(percept = factor(substring(percept, 5), levels=c("lowfreq", "mixed", "highfreq")))

