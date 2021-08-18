## Chi Squared Tests for RDT results comparison
library(readr)
library(dplyr)

data <- read_csv("results_comparison.csv")

chisq.test(data$qPCRcateg34, data$PfHRP2, correct = FALSE)
chisq.test(data$PfHRP2, data$qPCRcateg34,  correct = FALSE)
chisq.test(data$qPCRcateg34, data$qPCRcateg34, correct = FALSE)
chisq.test(data$PfHRP2, data$PfHRP2, correct = FALSE)

## Types 2 and 7
chisq.test(data$qPCRcateg34, data$ML_VE_2_7, correct = FALSE)
chisq.test(data$qPCRcateg34, data$ML_ERT_2_7, correct = FALSE)
chisq.test(data$PfHRP2, data$ML_VE_2_7, correct = FALSE)
chisq.test(data$PfHRP2, data$ML_ERT_2_7, correct = FALSE)

## Types 1 thru 24
chisq.test(data$qPCRcateg34, data$ML_VE_1thru24, correct = FALSE)
chisq.test(data$qPCRcateg34, data$ML_ERT_1thru24, correct = FALSE)
chisq.test(data$PfHRP2, data$ML_VE_1thru24, correct = FALSE)
chisq.test(data$PfHRP2, data$ML_ERT_1thru24, correct = FALSE)

## Type 3 and 5 and 10
chisq.test(data$qPCRcateg34, data$ML_VE_3_5_10, correct = FALSE)
chisq.test(data$qPCRcateg34, data$ML_ERT_3_5_10, correct = FALSE)
chisq.test(data$PfHRP2, data$ML_VE_3_5_10, correct = FALSE)
chisq.test(data$PfHRP2, data$ML_ERT_3_5_10, correct = FALSE)
