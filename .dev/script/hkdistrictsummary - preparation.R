library(dplyr)

## Initial set-up - DO NOT RERUN
# hkdc %>%
#   mutate(Code = substr(ConstituencyCode, start = 1, stop = 1)) %>%
#   select(Code, District_EN, District_ZH, Region_ZH, Region_ZH) %>%
#   group_by_all() %>%
#   summarise(n = n()) %>%
#   writexl::write_xlsx(here::here(".dev", "data", "hkdistrictsummary.xlsx"))

hkdistrict_summary <- readxl::read_xlsx(here::here(".dev", "data", "hkdistrictsummary.xlsx"))

## Use data
usethis::use_data(hkdistrict_summary)
