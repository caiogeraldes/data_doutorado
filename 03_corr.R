## Preparação
library(tidyverse)
library(readxl)
library(insight)

d <- read_csv("./processed/data_dist.csv")

# Corrigir 125
d[125, ]$TEXT <- "τὴν δέ οἱ συμβουλεῦσαι τῶν παίδων ἐόντων ἓξ τοὺς δύο ἐπὶ τὴν πυρὴν ἐκτείναντα γεφυρῶσαι τὸ καιόμενον, αὐτοὺς δὲ ἐπ᾽ ἐκείνων ἐπιβαίνοντας ἐκσώζεσθαι. ταῦτα ποιῆσαι τὸν Σέσωστριν, καὶ δύο μὲν τῶν παίδων κατακαῆναι τρόπῳ τοιούτῳ, τοὺς δὲ λοιποὺς ἀποσωθῆναι ἅμα τῷ πατρί." # nolint
d[125, ]$DIST_OBJ_PRED <- 11

# Corrigir 61 -> inf e pred trocados
(pred <- d[61, ]$Vinf)
(vinf <- d[61, ]$Pred)
d[61, ]$Vinf <- vinf
d[61, ]$Pred <- pred

# Corrigir 148  -> obj e pred trocados
(pred <- d[148, ]$Obj)
(obj <- d[148, ]$Pred)
d[148, ]$Obj <- obj
d[148, ]$Pred <- pred

# Corrigir 338  -> Inf e pred trocados
(pred <- d[338, ]$Vinf)
(vinf <- d[338, ]$Pred)
d[338, ]$Vinf <- vinf
d[338, ]$Pred <- pred

# Checar 120
d[120, ]$TEXT <- "ἐπεὶ δὲ τοῖσι Ὑπερβορέοισι τοὺς ἀποπεμφθέντας ὀπίσω οὐκ ἀπονοστέειν, δεινὰ ποιευμένους εἰ σφέας αἰεὶ καταλάμψεται ἀποστέλλοντας μὴ ἀποδέκεσθαι, οὕτω δὴ φέροντας ἐς τοὺς οὔρους τὰ ἱρὰ ἐνδεδεμένα ἐν πυρῶν καλάμῃ τοῖσι πλησιοχώροισι ἐπισκήπτειν κελεύοντας προπέμπειν σφέα ἀπὸ ἑωυτῶν ἐς ἄλλο ἔθνος." # nolint
(pred <- d[120, ]$Obj)
(obj <- d[120, ]$Pred)
d[120, ]$Obj <- obj
d[120, ]$Pred <- pred

# Corrigir attr de 106
d[106, ]$Attr <- TRUE

d <- d %>% mutate(
  t_c = NULL,
  CHECAR_DIST = NULL
)

write_csv(d, "./processed/data_corr.csv")
