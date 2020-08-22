library(tidyverse)

file1 <- read_csv(here::here(".dev", "data", "DC-contact.csv"))
file2 <- readxl::read_xlsx(here::here(".dev", "data", "HKDC Map_withDClinks2Final.xlsx"))
file3 <- read_csv(here::here(".dev", "data", "scraped-data.csv"))

# file2 %>% glimpse()
file3_clean <-
  file3 %>%
  select(ElectionYear = "electionYear",
         ElectionDate = "electionDate",
         CandidateNum = "candidateNum",
         Occupation = "occupation",
         Political = "political",
         Camp = "camp",
         Vote = "vote",
         VotePercentage = "votePercentage",
         name,
         Gender = "gender",
         Tag = "tag")

hkdc <-
  file2 %>%
  select(ConstituencyCode,
         Constituency_ZH,
         Constituency_EN,
         District_ZH,
         District_EN,
         Region_ZH,
         Region_EN,
         Party_ZH,
         Party_EN,
         DC_ZH,
         DC_EN,
         FacebookURL = "facebook",
         DCPageURL = "dc_links_col2") %>%
  left_join(file1, by = "ConstituencyCode") %>%
  mutate(DCProjectPageURL = paste0("https://hong-kong-districts-info.github.io/dc/", tolower(ConstituencyCode))) %>%
  rename(WebsiteURL = "Website") %>%
  left_join(file3_clean, by = c("DC_ZH" = "name"))

hkdc %>% glimpse()
hkdc %>% skimr::skim()
hkdc %>% names() %>% enframe()


usethis::use_data(hkdc, overwrite = TRUE)
