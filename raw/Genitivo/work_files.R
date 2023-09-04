require(readxl)
require(tidyverse)

# Processo:
# - Criar exportar resultados dos queries do Diorisis
# - Remover primeira linha da *sheet* "Search results"
# - Incluir na pasta deste script.
# - Rodar

filenames <- list.files(pattern = ".*\\.xlsx")

read_search_results <- function(file) {
  read_excel(path = file, sheet = "Search results", skip=1)
}

df <- map_df(filenames,
             .f = read_search_results,
             .id = "MVI") %>%
  separate_wider_delim(
    File,
    delim = "-",
    names = c("Author", "Work"),
    too_many = "merge"
  ) %>%
  mutate(
    MVI = str_replace(filenames[as.numeric(MVI)],
                      "\\.xlsx",
                      ""),
    Author = str_trim(Author),
    Work = str_trim(Work)
  ) %>%
  relocate(Author, Work, Location, Text) %>%
  rename("SID" = `Sentence ID`)

openxlsx::write.xlsx(df,
                     file = "../pessoais.xlsx")
