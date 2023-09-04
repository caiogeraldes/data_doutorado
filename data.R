require(tidyverse)
require(readxl)

df <- read_xlsx("./Geral.xlsx", sheet = "PRINCIPAL")
write_csv(df, "geral.csv")
geral <- read_csv(
  "geral.csv", col_types = cols(Anot = col_skip(),
  SID = col_skip(), `Anot. Extra` = col_skip())
) %>%
  rename(
    AUTHOR = "Author",
    WORK = "Work",
    LOCATION = "Location",
    SELECT = "Útil",
    CHECK = "CHECAR",
    MV_PERSONAL = "Pessoal",
    MV = "MVI"
  )
write_csv(geral, "geral.csv")
geral
