require(tidyverse)
require(readxl)
require(kableExtra)

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
    MV = "MVI",
    TEXT = "Text"
  )
write_csv(geral, "geral.csv")
geral


df <- geral %>% filter(SELECT=="TRUE")
write_csv(df, "data.csv")
df

df %>% select(AUTHOR, WORK, LOCATION, TEXT) %>%
kable(
  format="latex", 
  longtable=T, 
  booktabs=T) %>%
  kable_styling("striped") %>%
  write(file="data.tex")
1
