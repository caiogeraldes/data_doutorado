## Preparação
library(tidyverse)
library(readxl)
library(insight)

d <- read_csv("./processed/00_data_pre_processed.csv")

color_printer <- function(texto, mv, color) {
  require("stringr")
  texto <- texto
  if (!is.na(mv)) {
  texto <- str_replace(texto, mv,   color_text(mv, color))
  }
  return(texto)
}

d <- d %>% mutate(
      t_c = map2_chr(d$TEXT, d$Vm, color_printer, color = "red"),
)
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$VINF_A, color_printer, color = "green"),
      )
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$VINF_B, color_printer, color = "green"),
      )
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$VINF_C, color_printer, color = "green"),
      )
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$VINF_D, color_printer, color = "green"),
      )
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$OBJ_A, color_printer, color = "violet"),
      )
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$OBJ_B, color_printer, color = "violet"),
      )
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$OBJ_C, color_printer, color = "violet"),
      )
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$PRED_A, color_printer, color = "blue")
)
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$PRED_B, color_printer, color = "blue")
)
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$PRED_C, color_printer, color = "blue")
)
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$PRED_D, color_printer, color = "blue")
)
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$PRED_E, color_printer, color = "blue")
)
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$PRED_F, color_printer, color = "blue")
)
d <- d %>% mutate(
      t_c = map2_chr(d$t_c, d$PRED_G, color_printer, color = "blue")
)

for (i in 1:nrow(d)) { # nolint: seq_linter, cyclocomp_linter.
  print(i)
 cat(d$t_c[i][[1]], "\n")
}

write_csv(d, "./processed/01_data_colorized.R")
