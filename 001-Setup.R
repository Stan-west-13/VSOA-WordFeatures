library(dplyr)
library(tidyverse)
library(ggplot2)
library(readxl)

aoa <- read_xlsx("data/AoA_51715_words.xlsx")
feats <- read.csv("data/MBCDI_concsFeats_2022-07-14.csv")
vsoa <- readRDS("data/vsoa-autistic-nonautistic-ndar-id-fix-remodel-v2.rds")

## Then merge in VSOA and group from VSOA data.
cols <- c("Concept","LN_SUBTLEX","Num_Percep","Num_Ency","Num_Tax","Num_Func","Num_Vis_Mot","Num_VisFandS","Num_Vis_Col","Num_Sound","Num_Taste","Num_Smell","Num_Tact" )

feats_cols <- feats %>%
  select(all_of(cols)) %>%
  unique() %>%
  left_join(vsoa, by = c("Concept" = "word")) %>%
  left_join(aoa %>% select(Word, AoA_Kup_lem), by = c("Concept" = "Word") ) %>%
  mutate(aoa = as.numeric(AoA_Kup_lem)) %>%
  filter(!group == "ASD-NA") %>%
  droplevels() %>%
  select(-AoA_Kup_lem)

write_rds(feats_cols, file = "data/VSOA_WordFeats.rds")
