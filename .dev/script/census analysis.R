library(tidyverse)

census_dt <- readxl::read_xlsx(here::here(".dev", "data", "DistrictCensus.xlsx"), sheet = "Main")

census_dt <- census_dt %>% janitor::clean_names()

census_dt %>% names()

hkagepop19 <-
  census_dt %>%
  mutate(District = str_replace(qu_yi_hui_fen_qu_district_council_district, " ", "#")) %>%
  mutate(TotalProp = select(., "x0_14", "x15_24", "x25_44",
                            "x45_64", "x65") %>%
           apply(1, sum)) %>%
  mutate_at(vars(starts_with("x")), ~./TotalProp) %>%
  mutate_at(vars(starts_with("x")), ~.*nan_nu_he_ji_both_sexes) %>%
  select(District, starts_with("x"), TotalPopulation = "nan_nu_he_ji_both_sexes") %>%
  separate(col = "District", into = c("District_ZH", "District_EN"), sep = "#") %>%
  set_names(nm = str_replace(names(.), "x", "Age_")) %>%
  filter(!(District_EN %in% c("Hong Kong Island", "Kowloon", "New Territories")))
