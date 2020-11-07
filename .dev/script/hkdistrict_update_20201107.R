library(hkdatasets) # Load latest package version
library(dplyr)

# Store current version for back-up
# Use `write_excel_csv()` to preserve UTF-8 encoding
hkdc %>% readr::write_excel_csv(path = here::here(".dev", "data", "hkdc_static_20201107.csv"))

# Read current version back in
hkdc <- readr::read_csv(here::here(".dev", "data", "hkdc_static_20201107.csv"))

# Read in file to update
amend_file <- readxl::read_xlsx(here::here(".dev", "data", "missing_fb_links.xlsx"))

# Combine
hkdc <-
  hkdc %>%
  left_join(select(amend_file, ConstituencyCode, FacebookURLNew = "FacebookURL"),
            by = "ConstituencyCode") %>%
  # wpa::export()
  mutate(FacebookURL = case_when(is.na(FacebookURLNew) ~ FacebookURL,
                                 TRUE ~ FacebookURLNew)) %>%
  # select(ConstituencyCode, FacebookURL, FacebookURLNew) 
  select(-FacebookURLNew)
  
# Update package
hkdc %>% usethis::use_data(overwrite = TRUE)

