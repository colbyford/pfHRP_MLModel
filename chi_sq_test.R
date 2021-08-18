library(readr)
library(dplyr)

data <- read_csv("pfHRP2_withMeta.csv") %>%
  select(id, PfHRP2, qPCRcateg34)

chisq.test(data$qPCRcateg34, data$PfHRP2, correct = FALSE)
