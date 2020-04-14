library(dplyr)
library(readr)

pfhrp2 <- read.csv("pfHRP2_withMeta.csv")

pfhrp2 <- pfhrp2 %>% 
  mutate(PfHRP2_tf = ifelse(PfHRP2 == 1, T, F))

cors <- data.frame(type = character(0),
                   correlation = numeric(0))

for (i in 1:24){
  type <- paste0("Type_",i)
  cor_iter <- cor(pfhrp2$PfHRP2_tf, pfhrp2[[type]])
  
  cors_iter <- data.frame(type, cor_iter)
  cors <- rbind(cors, cors_iter)
}


# table(pfhrp2$PfHRP2_tf, pfhrp2[["Type_3"]])

pf_form <- as.formula(paste0("PfHRP2_tf ~ ", paste0("Type_",seq(1:24), collapse = " + ")))

logit_model <- glm(pf_form, family = "binomial", data = pfhrp2)
