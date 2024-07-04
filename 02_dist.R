## Preparação
library(tidyverse)
library(readxl)
library(insight)

d <- read_csv("./processed/01_data_colorized.R")

### Indexes automáticos

indexes <- function(a, b) {
  which(a == b)
}


text_tokenized <- str_remove_all(d$TEXT, regex("[\\.,;·]")) %>%
  str_replace_all(regex(" +"), " ") %>%
  str_split(" ")

d <- d %>% mutate(
  CHECAR_DIST = TRUE,
  DIST_OBJ_PRED = NA
)

# TODO: Validar os resultados da anotação automática dos dados

for (i in 1:nrow(d)) { # nolint: seq_linter, cyclocomp_linter.
  if (d[i, ]$CHECAR_DIST == TRUE) {
    print(str_c(
      i, "/", nrow(d),
      "(", 100 * round(i / nrow(d), digits = 2), "%)"
    ))
    print(str_trim(d[i, ]$TEXT))
    cat(d$t_c[i][[1]], "\n")
    print(str_trim(d[i, ]$Obj))
    print(str_trim(d[i, ]$Pred))
    index <- readline() %>% as.double()
    d[i, ]$DIST_OBJ_PRED <- index
    d[i, ]$CHECAR_DIST <- FALSE
  }
}

# 97, 120, 131, 136, 137
# 52! 152! 222! 4!

write_csv(d, "./processed/data_dist.csv")
