library(ggplot2)
library(dplyr)
library(pals)

create_plot <- function(data, age_cat, title_text, n_value) {
  data %>%
    ggplot(aes(x = month, y = cs, group = reorder(prev, num.msr), color = reorder(prev, num.msr))) +
    geom_line() +
    geom_line(data = . %>% filter(prev == "None"), aes(x = month, y = cs), color = "black") +
    scale_color_manual(name = "Measure", values = ocean.thermal(n = 11)) +
    labs(
      title = paste0(title_text, " (N=", n_value, ")"),
      x = "Year",
      y = "Deaths"
    ) +
    scale_y_continuous(expand = c(0, 0)) +
    scale_x_date(
      date_labels = "%Y",
      expand = c(0, 0)
    )
}

p1 <- create_plot(dat, "Stillbirth", "Stillbirth", 1190)
p2 <- create_plot(dat, "Neonate", "Neonate", 1340)
p3 <- create_plot(dat, "Infant/child", "Infant/child", 860)

