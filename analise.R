library(tidyverse)
library(readxl)
library(kableExtra)


## Coleta

diogenes_results <- read_excel("./assets/data.xlsx",
  sheet = "Principal"
)
diogenes_results



d <- read_csv("./processed/data_final.csv")
attach(d)
d


### Resultados da coleta no Diogenes

#### Autoria

table(diogenes_results$AUTHOR) %>% kable(
  col.names = c("Autor", "Freq"),
  format = "latex"
)



table(diogenes_results$AUTHOR) %>%
  prop.table() %>%
  kable(col.names = c("Autor", "Prop"),
  format = "latex"
)


#### Verbo principal


table(diogenes_results$MV) %>% kable(col.names = c("Vm", "Freq"),
  format = "latex"
)



table(diogenes_results$MV) %>%
  prop.table() %>%
  kable(col.names = c("Vm", "Prop"),
  format = "latex"
)


#### Total de dados:


nrow(diogenes_results)


### Dados filtrados

#### Autoria


table(d$AUTHOR) %>% kable(col.names = c("Autor", "Freq"),
  format = "latex"
)



table(d$AUTHOR) %>%
  prop.table() %>%
  kable(col.names = c("Autor", "Prop"),
  format = "latex"
)


#### Verbo principal

table(d$VM_LEMMA) %>% kable(col.names = c("Vm", "Freq"),
  format = "latex"
)


table(d$VM_LEMMA) %>%
  prop.table() %>%
  kable(col.names = c("Vm", "Prop"),
  format = "latex"
)


#### Total de dados:

nrow(d)


### Proporção de aproveitamento


nrow(d) / nrow(diogenes_results)


## Análise primária

### Proporção geral de atração


table(d$Attr) %>%
  addmargins() %>%
  kable(col.names = c("Atração", "Freq"),
  format = "latex"
)


prop.table(table(d$Attr)) %>%
  kable(col.names = c("Atração", "Prop"),
  format = "latex"
)


p <- ggplot(d, aes(Attr)) +
  geom_bar(aes(fill = Attr), width = 0.7) +
  labs(
    x = "", y = "Contagem",
    fill = "Attraction"
  ) +
  theme(
    axis.ticks.x = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank()
  ) +
  scale_fill_brewer(palette = "Dark2")
b <- p + labs(title = "Contagem da atração de caso")
b


### Proporção atração e classe de verbo (A)


table(d$VM_PERSONAL, d$Attr) %>%
  addmargins() %>%
  kable(
    col.names = c(
      "Vm Pessoal",
      "Sem atração",
      "Atração",
      "Soma"
    ),
    format = "latex"
  )



table(d$VM_PERSONAL, d$Attr) %>%
  prop.table(margin = 1) %>%
  kable(
    col.names = c(
      "Pessoal",
      "Sem atração",
      "Atração"
    ),
    format = "latex"
  )



table(d$VM_PERSONAL, d$Attr) %>% chisq.test()



lables <- c("FALSE" = "Personal Vm = False", "TRUE" = "Personal Vm = True")
b <- p + facet_wrap(. ~ VM_PERSONAL, labeller = as_labeller(lables)) +
  labs(title = "Atração de caso Vm pessoal")
b


### Proporção atração e classe de verbo (B)


table(d$VM_MOD, d$Attr) %>%
  addmargins() %>%
  kable(
    col.names = c(
      "Vm Modalizador",
      "Sem atração",
      "Atração",
      "Soma"
    ),
    format = "latex"
  )


table(d$VM_MOD, d$Attr) %>%
  prop.table(margin = 1) %>%
  kable(
    col.names = c(
      "Vm Modalizador",
      "Sem atração",
      "Atração"
    ),
    format = "latex"
  )


table(d$VM_MOD, d$Attr) %>% chisq.test()



lables <- c(
  "FALSE" = "Vm modalizador = False",
  "TRUE" = "Vm modalizador = True"
)
b <- p + facet_wrap(. ~ VM_MOD, labeller = as_labeller(lables)) +
  labs(title = "Atração de caso e Vm modalizador")
b


### Proporção atração e cópula


table(d$Vinf_Cop, d$Attr) %>%
  addmargins() %>%
  kable(
    col.names = c(
      "Vinf Copular",
      "Sem atração",
      "Atração",
      "Soma"
    ),
    format = "latex"
  )



table(d$Vinf_Cop, d$Attr) %>%
  prop.table(margin = 1) %>%
  kable(
    col.names = c(
      "Vinf Copular",
      "Sem atração",
      "Atração"
    ),
    format = "latex"
  )



table(d$Vinf_Cop, d$Attr) %>% chisq.test()



lables <- c("FALSE" = "Copula = False", "TRUE" = "Copula = True")
b <- p + facet_wrap(. ~ Vinf_Cop, labeller = as_labeller(lables)) +
  labs(title = "Atração de caso e infinitivo copular")
b


### Autoria


table(d$AUTHOR, d$Attr) %>%
  addmargins() %>%
  kable(
    col.names = c(
      "Autoria",
      "Sem atração",
      "Atração",
      "Soma"
    ),
    format = "latex"
  )


table(d$AUTHOR, d$Attr) %>%
  prop.table(margin = 1) %>%
  kable(
    col.names = c(
      "Autoria",
      "Sem atração",
      "Atração"
    ),
    format = "latex"
  )


table(d$AUTHOR, d$Attr) %>% chisq.test()



ggplot(d, aes(y = AUTHOR)) +
  geom_bar(aes(fill = Attr)) +
  labs(
    x = "Contagem", y = "Autor",
    fill = "Atração"
  ) +
  theme(text = element_text(size = 12)) +
  scale_fill_brewer(palette = "Dark2")


### Atração e distância


wilcox.test(d$DIST_OBJ_PRED ~ d$Attr, conf.int = TRUE)


b <- ggplot(d, aes(Attr, DIST_OBJ_PRED, fill = Attr)) +
  geom_boxplot(outlier.shape = 15, outlier.size = 2.4) +
  labs(
    y = "Distância entre Obj e Pred",
    title = "Distância entre Obj e Pred em relação com a atração"
  ) +
  theme(
    axis.ticks.x = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank()
  ) +
  scale_fill_brewer(palette = "Dark2")
b
