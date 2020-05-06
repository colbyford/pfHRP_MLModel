###################################
## Motif Frequencies by Location ##
##      Colby T. Ford, Ph.D.     ##
###################################

## Load in Packages
library(readr)
library(tidyr)
library(stringr)
library(dplyr)
library(ggplot2)

## Read in Motif Data
motifs <- read_csv("pfHRP_Motif_Matches.csv") %>%
  mutate(Location = substr(id,2,4)) %>% 
  mutate(Location = str_replace_all(Location, 
                                    c("Ass" = "Asosa",
                                      "Bab" = "Bambasi",
                                      "Kum" = "Kurmuk",
                                      "Shr"= "Sherkole"))) %>% 
  select(-c(dna_sequence, aa_sequence))

## Cast Data
data <- motifs %>%
  gather(variable, value, -c(Location, id)) %>% 
  # mutate(variable = as.numeric(substr(variable,6,length(variable)))) %>% 
  # arrange(variable)
  mutate(variable = factor(variable, levels=c(paste("Type", seq(1:24), sep = "_"))))
colnames(data) <- c("id", "Location", "Type", "Count")

# write_csv(data, "Motif_Frequencies_by_Location.csv")

## Plot Data
# ggplot(data %>% filter(!Type %in% paste("Type", c(4, 11, 15, 16, 17, 18, 20, 21, 22, 23, 24), sep = "_")),
ggplot(data,
       aes(x=Type, y=Count, fill=Location)) + 
  # geom_boxplot() +
  geom_violin(trim=T) +
  # geom_boxplot(width=0.1, fill="white") +
  # geom_dotplot(binaxis='y', stackdir='center', dotsize=1) +
  # stat_summary(fun.y=mean, geom="point", shape=23, size=2) +
  facet_wrap(~Type, scale="free") +
  scale_y_continuous(name = "Motif Matches",
                     limits = c(0, 13),
                     breaks = c(0, 5, 10, 13)) +
  theme_bw() +
  theme(plot.title = element_text(size = 12, family = "Arial", face = "bold"),
        text = element_text(size = 10, family = "Arial"),
        axis.title = element_text(face="bold"),
        # axis.text.x=element_text(size = 11),
        legend.position="right",
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  scale_fill_brewer(palette = "Set1")

