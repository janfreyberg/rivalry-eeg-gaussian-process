library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(stringr)

data <- read_csv('all-results.csv')

# The course over any given period
columnlead <- "timecourse_"
timedata <- data %>%
  select(id, starts_with(columnlead)) %>%
  gather(percepttime, probability, -id) %>%
  mutate(percepttime = str_replace(percepttime, columnlead, "")) %>%
  separate(percepttime, c("percept", "time"), sep="_", convert=TRUE)

# The course over a mixed period, split by what comes next
columnlead <- "mixnext_"
timedata.mix.bynext <- data %>%
  select(id, starts_with(columnlead)) %>%
  gather(percepttime, probability, -id) %>%
  mutate(percepttime = str_replace(percepttime, columnlead, "")) %>%
  separate(percepttime, c("percept", "time"), sep="_", convert=TRUE)

# The course over a dominant period, split by what comes next
columnlead <- "domnext_"
timedata.dominant.bynext <- data %>%
  select(id, starts_with(columnlead)) %>%
  gather(percepttime, probability, -id) %>%
  mutate(percepttime = str_replace(percepttime, columnlead, "")) %>%
  separate(percepttime, c("current", "following", "time"), sep="_", convert=TRUE) %>%
  # match the two dominant outcomes for better plotting
  mutate(following = str_replace(following, "highfreq|lowfreq", "dominant"))

# The course of the "wta" index
columnlead <- "winnerindex_"
timedata.wta <- data %>%
  select(id, starts_with(columnlead)) %>%
  gather(percepttime, probability, -id) %>%
  mutate(percepttime = str_replace(percepttime, columnlead, "")) %>%
  separate(percepttime, c("percept", "time"), sep="_", convert=TRUE)
  
# The average prediction, binned by percept
columnlead = "mean"
averagedata.bypercept <- data %>%
  select(id, starts_with(columnlead)) %>%
  gather(percept, probability, -id) %>%
  # Fix the levels for plotting
  mutate(percept = percept %>% str_replace(columnlead, "") %>%
           factor(levels=c("lowfreq", "mixed", "highfreq")))

# Average correlation strength, binned by percept
columnlead = "correlation_"
correlations.bypercept <- data %>%
  select(id, starts_with(columnlead)) %>%
  gather(percept, corrstrength, -id) %>%
  mutate(percept = percept %>% str_replace(columnlead, "") %>%
           # also fix factor levels here
           factor(levels=c("lowfreq", "mixed", "highfreq")))
