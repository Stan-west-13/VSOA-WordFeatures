library(dplyr)
library(ggplot2)
library(tidyverse)
vsoa_feats <- read_rds("data/VSOA_WordFeats.rds")

## Linear model #####################################
contrasts(vsoa_feats$group)

## VSOA
m_vsoa <- lm(vsoa ~ LN_SUBTLEX + (Num_Percep + Num_Ency + Num_Tax + Num_Func) * group, data = vsoa_feats)
summary(m_vsoa)

## AoA
m_aoa <- lm(aoa ~ LN_SUBTLEX + (Num_Percep + Num_Ency + Num_Tax + Num_Func) * group, data = vsoa_feats)
summary(m_aoa)

## Percep Features
m_vsoa_percep <- lm(vsoa ~ (Num_Vis_Mot + Num_VisFandS + Num_Vis_Col + Num_Sound + Num_Taste + Num_Smell + Num_Tact) * group, data = vsoa_feats)
summary(m_vsoa_percep)
#####################################################

## Plots

## Plotting dataframe
plot_df <- vsoa_feats %>%
  pivot_longer(cols = starts_with(c("Num","LN"),ignore.case=FALSE),
               names_to = "Measure",
               values_to = "value")

## Histograms of IVs

ggplot(plot_df,aes(x = value))+
  geom_histogram()+
  facet_wrap(~Measure,scales = "free")
ggsave("Figures/histogram_feats.png")
## Plot features and VSOA
ggplot(plot_df, aes(x = vsoa, y = value,color = group))+
  geom_point(alpha = 0.5) + 
  geom_smooth(method = "lm") +
  facet_wrap(~Measure,scales = "free")
ggsave("Figures/VSOA_feats.png")

## Plot features and AoA
ggplot(plot_df, aes(x = aoa, y = value,color = group))+
  geom_point(alpha = 0.5) + 
  geom_smooth(method = "lm") +
  facet_wrap(~Measure,scales = "free")
ggsave("Figures/AoA_feats.png")
