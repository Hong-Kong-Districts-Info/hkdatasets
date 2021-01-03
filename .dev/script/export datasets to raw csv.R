library(hkdatasets)
library(dplyr)

hkdc %>% readr::write_excel_csv("data-raw/hkdc.csv")
hkstreetnames20 %>% readr::write_excel_csv("data-raw/hkstreetnames20.csv")
hkdistrict_summary %>% readr::write_excel_csv("data-raw/hkdistrict_summary.csv")
hk_accidents %>% readr::write_excel_csv("data-raw/hk_accidents.csv")
hk_casualties %>% readr::write_excel_csv("data-raw/hk_casualties.csv")
hk_vehicles %>% readr::write_excel_csv("data-raw/hk_vehicles.csv")
