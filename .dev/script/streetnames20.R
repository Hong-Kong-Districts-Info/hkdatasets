library(dplyr)

pre_streetnames20 <- readxl::read_xlsx(here::here(".dev", "data", "PSI_Street Name_20200630.xlsx"))

## Prepare data
hkstreetnames20 <-
  pre_streetnames20 %>%
  select(DC = "Dist_Council1",
         StreetNames_EN = `English Name`,
         StreetNames_ZH = `Chinese Name`)

## Explore
# hkstreetnames20 %>%
#   tidyr::separate(DC, into = c("DC1", "DC2", "DC3", "DC4", "DC5"), sep = "-") %>%
#   filter(!is.na(DC4))

## Check that there are just 18 values
dc_str <-
  hkstreetnames20 %>% 
  pull(DC) %>%
  strsplit(split = "-") %>%
  unlist() %>%
  unique()

## Create dummy columns
dum_cols <-
  dc_str %>%
  purrr::map(function(x){
    hkstreetnames20 %>%
      mutate(!!sym(x) := stringr::str_detect(DC, x)) %>%
      select(x)
  }) %>%
  bind_cols() %>%
  cbind(StreetNames_EN = hkstreetnames20$StreetNames_EN, .)

## bind with original df
hkstreetnames20 <- left_join(hkstreetnames20, dum_cols, by = "StreetNames_EN")
  
  
## Add data
usethis::use_data(hkstreetnames20, overwrite = TRUE)


