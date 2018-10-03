library(tidyverse)
library(nycflights13)
library(glue)

ship_var <- function(var_name, file_name){
  var_string <- deparse(substitute(var_name))
  tex_var <- glue(
    "\\newcommand{\\[var_string]}{[var_name]}", 
    .open = "[",
    .close = "]")
  write(tex_var, file_name, append = FALSE)
}


f_plot <- flights %>%
  sample_frac(size = 0.005) %>%
  mutate(month = factor(month)) %>%
  ggplot(aes(log(air_time), log(distance), colour = month)) +
  geom_point() + 
  theme_minimal(base_size = 20) +
  xlab("log air time") +
  ylab("log distance")

ggsave(filename = "flight.pdf", plot = f_plot)
ggsave(filename = "flight.png", plot = f_plot, device = "png")

meandistance <- mean(flights$distance)
ship_var(meandistance, "r_vars.tex")
