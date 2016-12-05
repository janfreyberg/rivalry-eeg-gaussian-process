
# Plot the x and y course
ggplot(timedata.wta, aes(x=time, y=probability, group=percept, color=percept, fill=percept)) +
  theme_bw() + theme(legend.position=c(0.9, 0.9)) +
  geom_ribbon(aes(color=NULL), stat="summary", fun.data=mean_se, alpha=0.2) +
  geom_line(stat="summary", fun.y=mean, size=1) +
  labs(x="Time (Fraction of total percept duration)",
       y="Probability of Percept being 'High'",
       fill="Actual Report") +
  guides(color=FALSE)
