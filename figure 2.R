library(dplyr)
library(ggplot2)

tmp %>%
  ggplot(aes(y = reorder(rec, desc(rec)), x = prop, fill = type)) + 
  geom_point(shape = 21, color = 'black') +
  labs(
    x = "Proportion of deaths potentially averted", 
    y = "Health system improvement"
  ) +
  scale_fill_manual(
    name = "Assumption",
    values = tol(3)
  ) +
  scale_x_continuous(labels = scales::percent) +
  facet_grid(~age.cat) +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = .5),
    strip.background = element_rect(fill = 'grey45', color = "black"),
    legend.position = "bottom",
    strip.text = element_text(size = 10.5, face = "bold", color = "white"),
    axis.title = element_text(face = 'bold', size = 11),
    legend.title = element_text(face = 'bold', size = 10),
    legend.text = element_text(size = 10.5),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  ) 
