ggplot(averagedata.bypercept, aes(x = percept, y=probability, group=percept, colour=percept)) +
  theme_bw() + ylim(0.25, 0.75) +
  labs(x="Actual Percept", y="Probability of percept being 'High'") +
  geom_pointrange(stat="summary", fun.data=mean_se, show.legend=FALSE)
