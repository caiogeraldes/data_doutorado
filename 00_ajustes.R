## Preparação
library(tidyverse)
library(readxl)

diogenes_results <- read_excel(
  "./assets/data.xlsx",
  sheet = "Principal"
) %>% select(!Column1)
diogenes_results

mvi <- read_csv("./assets/mvi.csv")
mvi <- mvi %>%
  mutate(
    modal_semantics = (mvi$modal_semantics == 1),
    personal = (mvi$personal == 1),
    impersonal = (mvi$impersonal == 1)
  )
modal_verbs <- (
  mvi %>%
    filter(mvi$modal_semantics)
)$lemma
modal_verbs

d <- diogenes_results %>%
  ## Separando apenas entradas de interesse
  filter(diogenes_results$SELECT == TRUE) %>%
  ## Removendo o critério de seleção
  select(!SELECT) %>%
  ## Dividindo entradas com múltiplos hits
  separate_wider_delim(
    Pred, ",",
    names = c(
      "PRED_A", "PRED_B", "PRED_C", "PRED_D", "PRED_E", "PRED_F", "PRED_G"
    ), too_few = "align_start",
    cols_remove = FALSE
  ) %>%
  separate_wider_delim(
    Vinf, ", ",
    names = c(
      "VINF_A", "VINF_B", "VINF_C", "VINF_D"
    ), too_few = "align_start",
    cols_remove = FALSE
  ) %>%
  separate_wider_delim(
    Obj, ", ",
    names = c(
      "OBJ_A", "OBJ_B", "OBJ_C"
    ), too_few = "align_start",
    cols_remove = FALSE
  ) %>%
  ## Anotando automaticamente se o verbo é modalizante
  mutate(
    VM_MOD = (MV %in% modal_verbs)
  ) %>%
  ## Reordenando as colunas
  relocate(
    ID,
    AUTHOR, WORK, LOCATION, TEXT,
    Vm, MV, MV_PERSONAL, VM_MOD,
    Vinf, VINF_A, VINF_B, VINF_C, VINF_D, Vinf_Cop,
    Obj, OBJ_A, OBJ_B, OBJ_C,
    Pred, PRED_A, PRED_B, PRED_C, PRED_D, PRED_E, PRED_F, PRED_G,
    Attr, Attr_B
  ) %>%
  ## Renomeando entradas
  rename(all_of(
    c(
      VM_LEMMA = "MV",
      VM_PERSONAL = "MV_PERSONAL"
    )
  ))

colnames(d)
write_csv(d, "./processed/00_data_pre_processed.csv")
