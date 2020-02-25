###################################
## pfHRP2 Machine Learning Model ##
##    By: Colby T. Ford, Ph.D.   ##
###################################

library(dplyr)
library(readr)
library(tidyr)

## Load in Motif Data
fastas_df <- read_csv("pfHRP_Motif_Matches.csv")
## Load in metadata
metadata <- read_csv("metadata.csv")

## Join Together
full_df <- fastas_df %>%
  inner_join(metadata, by = c("id" = "Id")) %>% 
  mutate_at(c("workLiving",
              "Address",
              "PfHRP2",), as.factor)



                                    