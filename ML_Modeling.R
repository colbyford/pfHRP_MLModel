###################################
## pfHRP2 Machine Learning Model ##
##    By: Colby T. Ford, Ph.D.   ##
###################################

library(dplyr)
library(readr)
library(tidyr)

## Load in Motif Data
fastas_df <- read_csv("pfHRP_Motif_Matches.csv") %>% filter(gene == "pfhrp2")
## Load in metadata
metadata <- read_csv("metadata.csv")

## Join Together
full_df <- fastas_df %>%
  inner_join(metadata, by = c("id" = "Id")) %>% 
  mutate_at(c("workLiving",
              "Address",
              "ResultBF",
              "SpeciesmalaBF",
              "PfPLDH",
              "PfHRP2",
              "qPCRcateg34",
              "paradencateg"), as.factor)

model_formula <- as.formula(paste("PfHRP2 ~ ", paste(paste("Type_", 1:24, sep=""), collapse= "+")))

lr_mod <- glm(model_formula,
              data = full_df,
              family = binomial(link = "logit"))


                                    