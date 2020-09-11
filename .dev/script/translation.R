# Load packages-----------------------------------------------------------------
library(tidyverse)
library(here)
library(hkdatasets)

# Load font ---------------------------------------------------------------
showtext::showtext_auto()

# Read data---------------------------------------------------------------------
load(here("data", "hkdc.rda"))

# Translate 'Political'---------------------------------------------------------
## Rename 'Political'
hkdc <- hkdc %>%
  rename(Political_ZH = Political)

## Read in English translation
Political_EN <- read.csv(here(".dev", "data", "Political_EN.csv"))

## Translate
hkdc <- hkdc %>%
  left_join(Political_EN, by = c("Political_ZH" = "ZH")) %>%
  rename(Political_EN = 'EN') %>%
  relocate(Political_EN, .after = Political_ZH)

# Translate 'Camp'--------------------------------------------------------------
## Rename "Camp"
hkdc <- hkdc %>%
  rename(Camp_ZH = Camp)

## Translate
hkdc <- hkdc %>%
  mutate(Camp_EN = case_when(
    Camp_ZH == "其他" ~ "Others",
    Camp_ZH == "建制" ~ "Pro-Beijing",
    Camp_ZH == "泛民" ~ "Pro-democracy",
    TRUE ~ "NA"
  )) %>%
  relocate(Camp_EN, .after = Camp_ZH)

# Translate 'Gender'------------------------------------------------------------
## Rename "Gender"
hkdc <- hkdc %>%
  rename(Gender_ZH = Gender)

## Translate
hkdc <- hkdc %>%
  mutate(Gender_EN = case_when(
    Gender_ZH == "女" ~ "Female",
    Gender_ZH == "男" ~ "Male",
    TRUE ~ "NA"
  )) %>%
  relocate(Gender_EN, .after = Gender_ZH)

# Translate 'Tag'---------------------------------------------------------------
## Rename "Tag"
hkdc <- hkdc %>%
  rename(Tag_ZH = Tag) %>%
  mutate(Tag_ZH = case_when(
    Tag_ZH == "泛民獨立\n" ~ "泛民獨立",
    TRUE ~ Tag_ZH
  ))

## Translate
hkdc <- hkdc %>%
  mutate(Tag_EN = case_when(
    Tag_ZH == "中間路線" ~ "Centrist Camp",
    Tag_ZH == "其他" ~ "Others",
    Tag_ZH == "建制政黨" ~ "Pro-Beijing Camp/ Party member",
    Tag_ZH == "建制獨立" ~ "Pro-Beijing Camp/ Independent",
    Tag_ZH == "泛民政黨" ~ "Pro-democracy Camp/ Party member",
    Tag_ZH == "泛民獨立" ~ "Pro-democracy Camp/ Independent",
    TRUE ~ "NA"
  )) %>%
  relocate(Tag_EN, .after = Tag_ZH)


# Save dataset------------------------------------------------------------------
save(hkdc, file = "hkdc.rda")
