ggplot(correlations.bypercept, aes(x=percept, y=corrstrength, group=percept, colour=percept)) +
  theme_bw() +
  labs(x="Actual Percept", y="Probability of percept being 'High'") +
  geom_pointrange(stat="summary", fun.data=mean_se, show.legend=FALSE)
