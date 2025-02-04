
#this is a quick analysis script

library(ggplot2)
library(here)

data = data.frame(values = rnorm(1000, 0, 2))

ggplot(data) +
  geom_histogram(aes(values)) +
  theme_bw()

filename = gsub(c(" "), "_", format(as.POSIXct(Sys.time()), tz = "Europe/London", usetz = TRUE))
filename = gsub(":", "-", filename)

ggsave(here::here("Results", paste0(filename, ".png")))
