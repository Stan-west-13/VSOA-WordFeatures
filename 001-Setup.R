feats <- read.csv("data/MBCDI_concsFeats_2022-07-14.csv")
library(dplyr)
library(tidyverse)
library(ggplot2)

## Then merge in VSOA and group from VSOA data.
cols <- c("Concept","LN_SUBTLEX","Num_Percep","Num_Ency","Num_Tax","Num_Func" )

feats_cols <- feats %>%
  select(all_of(cols)) %>%
  unique() %>%
  mutate(VSOA = rnorm(n()*2))


## Linear model

m <- lm(VSOA ~ (Num_Percep + Num_Ency + Num_Tax + Num_Func) * group)