###################################
## Search of pfHRP Motif Repeats ##
##    By: Colby T. Ford, Ph.D.   ##
###################################

library(Biostrings)
library(ape)
library(bio3d)
library(dplyr)
library(readr)
library(purrr)
library(stringr)

# HShr122 <- DNAString("TTATTACACGAAACTCAAGCACATGTAGATGATGCCCATCATGCTCATCATGTAGCCGATGCCCATCATGCTCATCATGTAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCTATGCCCATCATGCTCATCATGCAGCCGATGCTCACCATGCAACCGATGCTCATCATGCAGCCGATGCTCACCATGCAGCCGATGCTCACCATGCAACCGATGCTCATCACGCTCATCATGCAGCCGATGCCCATCACGCTCACCATGCAGCCGATGCTCATCAYGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCGATGCCCATCATGCTCACCATGCAGCTGATGCTCATCACGCTCATCATGCAGCCGATGCCCATCATGCTCATCATGCAGCCTATGCCCATCATGCTCATCATGCATCCGATGCTCATCATGCAGCTGATGCTCACCATGCAGCTTATGCCCATCACGCTCATCATGCAGCTGATGCTCATCATGCAGCCGATGCTCACCATGCAACCGATGCTCATCACGCTCACCATGCAGCCGATGCTCACCATGCAACCGATGCTCATCATGCAGCCGATGCTCACCATGCAGCCGATGCTCACCATGCAGCCGATGCTCATCATGCAGCCGCACACCATGCAACTGATGCTCACCATGCAGCCGCACACCATGCAACCGATG")
#
# HShr122_aa <- translate(HShr122, if.fuzzy.codon="solve")


## Find All Fasta Files
fastapaths <- c(list.files(path="consensus_sequences_pfhrp2_exon2/Plate A done", pattern = ".fasta", full.names = TRUE),
                list.files(path="consensus_sequences_pfhrp2_exon2/Plate B done", pattern = ".fasta", full.names = TRUE),
                list.files(path="consensus_sequences_pfhrp2_exon2/Plate C done", pattern = ".fasta", full.names = TRUE),
                list.files(path="consensus_sequences_pfhrp2_exon2/Plate D done", pattern = ".fasta", full.names = TRUE),
                list.files(path="consensus_sequences_pfhrp3_exon2/Plate A", pattern = ".fasta", full.names = TRUE),
                list.files(path="consensus_sequences_pfhrp3_exon2/Plate B", pattern = ".fasta", full.names = TRUE),
                list.files(path="consensus_sequences_pfhrp3_exon2/Plate C", pattern = ".fasta", full.names = TRUE),
                list.files(path="consensus_sequences_pfhrp3_exon2/Plate D", pattern = ".fasta", full.names = TRUE))

## Read all in as DNA
fastas <- readDNAStringSet(fastapaths)
## Extract names from Fasta header lines
fastas_names <- fastas@ranges@NAMES

## Create Data frame of all sequences
fastas_df <- data.frame(fastas_names,
                        fastapaths,
                        fastas %>% as.data.frame())
colnames(fastas_df) <- c("id", "path", "dna_sequence")

## Extract gene from path
fastas_df$gene <- str_extract(fastas_df$path,"(pf[A-Za-z0-9]+)")

## Align DNA Sequences
# library(msa)
# aligned <- msa(fastas, method = "ClustalOmega", verbose = TRUE)

## Translate DNA sequence to Amino Acids
# fastas_df$aa_sequence <- fastas_df$dna_sequence %>% DNAStringSet() %>% translate(if.fuzzy.codon="solve")

## Fix to use ExPASy Translations
fastas_df <- readxl::read_xlsx("pfHRP2_Exon_2_ExPASy.xlsx") %>% select(id, dna_sequence, ExPASy_aa_sequence)
colnames(fastas_df) <- c("id","dna_sequence","aa_sequence")

## Fix to use trimmed sequence if necessary
# fastas_df <- readxl::read_xlsx("pfHRP2_Exon_2_ExPASy.xlsx") %>%
#   mutate(aa_sequence = ifelse(trimmed_ExPASy_aa_sequence == "n/a", ExPASy_aa_sequence, trimmed_ExPASy_aa_sequence)) %>%
#   select(id, dna_sequence, aa_sequence)


## Read in Motif reference
motifs <- read_csv("Baker_AA_Repeats.csv")

## Determine Motif Type names and create empty placeholder columns for them
typenames <- paste0("Type_", motifs$Type)

for(i in typenames){
  fastas_df[,i] <- NA
}


# type4_motif <- c("AHH")
#
# map(motifs$AA_Repeats, function(x) length(motif.find(x, HShr122_aa)))
#
# length(motif.find(type4_motif, HShr122_aa))

#
# count_motifs <- function(data, motifs, motif_column = NULL, motif_name_column = NULL){
#   motif_list <- motifs[[motif_column]]
#   motif_names <- motifs[[motif_name_column]]
#
#   output <- map(motif_list, function(x) length(motif.find(x, data))) %>%
#     as.data.frame()
#
#   typenames <- paste0(motif_name_column, "_", motif_names)
#
#   colnames(output) <- typenames
#   return(output)
# }
#
# ## Test
# # count_motifs(data = HShr122_aa, motifs = motifs, motif_column = "AA_Repeats", motif_name_column = "Type")
# count_motifs(data = fastas_df$sequence[1], motifs = motifs, motif_column = "AA_Repeats", motif_name_column = "Type")
#
#
# for (i in 1:nrow(fastas_df)){
#
#    fastas_df[i,4:21] <- count_motifs(data = fastas_df$sequence[i],
#                                             motifs = motifs,
#                                             motif_column = "AA_Repeats",
#                                             motif_name_column = "Type")
#
# }


########################

## Loop through each sequence and each motif and count the number of matches (repeats)

for (i in 1:nrow(fastas_df)){
  for (j in 1:nrow(motifs)){
    fastas_df[i,paste0("Type_",motifs$Type[j])] <- motif.find(motifs$Sequence[j], fastas_df$aa_sequence[i]) %>%
      Filter(function(i) i >= 0, .) %>% ## Remove reverse matches (e.g. -12)
      length()
  }
}

## Write out result
write_csv(fastas_df, "pfHRP_Motif_Matches.csv")


#####################
## Add Metadata
# fastas_df <- read_csv("pfHRP_Motif_Matches.csv")
## Load in metadata
metadata <- read_csv("metadata.csv")

## Join Together
full_df <- fastas_df %>%
  # full_df <- all_hrps %>%
  # full_df <- hrp2s %>%
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
