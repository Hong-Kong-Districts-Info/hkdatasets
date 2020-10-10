library(dplyr)

pre_streetnames20 <- readxl::read_xlsx(here::here(".dev", "data", "PSI_Street Name_20200630.xlsx"))


hkstreetnames20 <-
  pre_streetnames20 %>%
  select(DC = "Dist_Council1",
         StreetNames_EN = `English Name`,
         StreetNames_ZH = `Chinese Name`)
  
usethis::use_data(hkstreetnames20)
