
# Plot the x and y course
ggplot(timedata, aes(x=time, y=probability, group=percept, color=percept, fill=percept)) +
  theme_bw() +
  geom_ribbon(aes(color=NULL), stat="summary", fun.data=mean_se, alpha=0.2) +
  geom_line(stat="summary", fun.y=mean, size=1) +
  labs(x="Time (Fraction of total percept duration)",
       y="Probability of Percept being 'High'",
       fill="Actual Report") +
  guides(color=FALSE)

# ggplot(timedata.bynext, aes(x=time, y=probability, group=percept, color=percept, fill=percept)) +
#   theme_bw() +
#   # Individual data lines
#   # geom_line(aes(group=interaction(id, percept)), alpha=0.2, stat="summary", fun.y="mean") +
#   # Group Line + SE area
#   geom_ribbon(aes(color=NULL), stat="summary", fun.data=mean_se, alpha=0.2) +
#   geom_line(stat="summary", fun.y=mean, size=1) +
#   labs(x="Time (Fraction of total percept duration)",
#        y="Probability of next percept being 'High'",
#        fill="Actual next report") +
#   guides(color=FALSE)