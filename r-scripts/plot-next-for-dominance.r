ggplot(timedata.dominant.bynext, aes(x=time, y=probability, group=interaction(current, following),
                                     color=current, fill=current, linetype=following)) +
  theme_bw() + theme(legend.position=c(0.2, 0.5)) +
  # Individual data lines
  # geom_line(aes(group=interaction(id, percept)), alpha=0.2, stat="summary", fun.y="mean") +
  # Group Line + SE area
  geom_ribbon(aes(color=NULL), stat="summary", fun.data=mean_se, alpha=0.2) +
  geom_line(stat="summary", fun.y=mean, size=1) +
  labs(x="Time (Fraction of total percept duration)",
       y="Probability of the current percept being 'High'",
       legend="Actual current report") +
  guides(color=FALSE)
