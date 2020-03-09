###################################
## pfHRP2 Machine Learning Model ##
##    By: Colby T. Ford, Ph.D.   ##
###################################

library(dplyr)
library(readr)
library(tidyr)

## Load in Motif Data
fastas_df <- read_csv("pfHRP_Motif_Matches.csv")
hrp2s <- fastas_df %>% filter(gene == "pfhrp2")
hrp3s <- fastas_df %>% filter(gene == "pfhrp3")
all_hrps <- hrp2s %>% full_join(hrp3s, by = "id", suffix = c("_pfhrp2", "_pfhrp3"))

## Load in metadata
metadata <- read_csv("metadata.csv")

## Join Together
# full_df <- fastas_df %>%
# full_df <- all_hrps %>%
full_df <- hrp2s %>%
  na.omit() %>% ## Comment out to include missing values
  inner_join(metadata, by = c("id" = "Id")) %>% 
  mutate_at(c("workLiving",
              "Address",
              "ResultBF",
              "SpeciesmalaBF",
              "PfPLDH",
              "PfHRP2",
              "qPCRcateg34",
              "paradencateg"), as.factor)

write_csv(full_df, "pfHRP2_withMeta.csv")

# model_formula <- as.formula(paste("PfHRP2 ~ ",
#                                   paste(paste("Type_", 1:24, "_pfhrp2", sep=""), collapse= "+"),
#                                   "+",
#                                   paste(paste("Type_", 1:24, "_pfhrp3", sep=""), collapse= "+")))


model_formula <- as.formula(paste("PfHRP2 ~ ",
                            paste(paste("Type_", 1:24, sep=""),
                                  collapse= "+")))

lr_mod <- glm(model_formula,
              data = full_df,
              family = binomial(link = "logit"))


                                    