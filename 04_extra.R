## Preparação
library(tidyverse)
library(readxl)

d <- read_csv("./processed/data_corr.csv")

d <- d %>% mutate(
  GENRE = ifelse(
    AUTHOR == "Xenophon (0032)",
    ifelse(
      WORK %in% c(
        "Anabasis (006)",
        "Cyropaedia (007)",
        "Hellenica (001)",
        "Agesilaus (009)"
      ),
      "historiography",
      ifelse(
        WORK %in% c(
          "Memorabilia (002)",
          "Apology (005)",
          "Hiero (008)",
          "Economics (003)",
          "Symposium (004)"
        ),
        "philosophical_dialogue",
        ifelse(
          WORK == "Constitution of the Lacedaemonians (010)",
          "juridical",
          "other"
        )
      )
    ),
    ifelse(
      AUTHOR %in% c(
        "Aeschylus (0085)",
        "Aristophanes (0019)",
        "Euripides (0006)",
        "Sophocles (0011)"
      ),
      "drama",
      ifelse(
        AUTHOR %in% c(
          "Herodotus (0016)",
          "Thucydides (0003)"
        ),
        "historiography",
        ifelse(
          AUTHOR == "Plato (0059)",
          "philosophical_dialogue",
          "juridical"
        )
      )
    )
  )
)
d$GENRE

d <- d %>% mutate(DIALECT = ifelse(
  AUTHOR == "Herodotus (0016)", "jonic", "attic"
))
d$DIALECT

write_csv(d, "./processed/data_final.csv")
