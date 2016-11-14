library(tidyr)
library(dplyr)
library(ggplot2)

data <- read.csv("predictionaccuracy.csv")
data$lowfreq = 1 - data$lowfreq
precisiondata <- read.csv("predictionprecision.csv")
data$mixedprecision = precisiondata$mixed
data$highprecision = precisiondata$highfreq
data$lowprecision = precisiondata$lowfreq
proportiondata <- read.csv("perceptproportions.csv")
data$mixedproportion = proportiondata$mixed
data$highproportion = proportiondata$highfreq
data$lowproportion = proportiondata$lowfreq

ggplot(data, aes(x=highfreq, y = lowfreq)) +
  geom_point()

ggplot(data, aes(x=mixed, y = lowfreq)) +
  geom_point()

ggplot(data, aes(x = highfreq, y = highprecision)) +
  geom_point()

ggplot(data, aes(x = mixed, y = mixedprecision)) +
  geom_point()

ggplot(data, aes(x = mixedprecision, y = mixedproportion)) +
  geom_point()