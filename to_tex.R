require(tidyverse)
require(kableExtra)

df <- read_csv("./processed/data_final.csv")

df %>%
  select(AUTHOR, WORK, LOCATION, TEXT) %>%
  kable(
    format = "latex",
    longtable = T,
    booktabs = T
  ) %>%
  kable_styling("striped") %>%
  write(file = "data.tex")
