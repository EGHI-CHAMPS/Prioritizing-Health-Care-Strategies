library(ggplot2)

ggplot(tmp, aes(x = prev, y = n, fill = prev)) +
  geom_col(position = "dodge") +
  geom_text(aes(label = prop), vjust = -0.7, size = 3.4, color = "black") +
  scale_y_continuous(expand = expansion(mult = c(0, .08))) +
  facet_wrap(~age.cat, nrow = 1) +
  labs(x = "Age group", y = "Deaths") +
  scale_fill_manual(name = "Number of categories", values = rev(tol(n = 4))) +
  theme(
    strip.text = element_text(size = 10.5, face = "bold", color = "white"),
    strip.background = element_rect(fill = 'grey45', color = "black"),
    axis.title = element_text(face = 'bold', size = 11.5),
    axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
    axis.text.y = element_text(size = 10),
    legend.position = "none",
    panel.border = element_rect(color = "black", fill = NA, size = .5),
    plot.margin = margin(.2, .2, .2, .9, "cm")
  )