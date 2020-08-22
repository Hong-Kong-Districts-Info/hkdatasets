library(tidyverse)
library(HK80)

file_acc <- readxl::read_xlsx(here::here(".dev", "data", "Accident 2014-2019.xlsx"))
file_veh <- readxl::read_xlsx(here::here(".dev", "data", "Vehicle 2014-2019.xlsx"))
file_cas <- readxl::read_xlsx(here::here(".dev", "data", "Casuality 2014-2019.xlsx"))

attach_latlong <- function(data, gridn, gride){
  
  data <-
    data %>%
    mutate_at(vars(gridn, gride),
              ~ifelse(. == "NA", NA, .) %>%
                as.numeric())
  
  # data <- tidyr::drop_na(data)
  
  grid_n <- data[[gridn]]
  grid_e <- data[[gride]]
  
  suppressWarnings(
    results <- HK80::HK1980GRID_TO_WGS84GEO(grid_n, grid_e)
  )
  
  cbind(data, results)
}


hk_accidents <- attach_latlong(file_acc, "Grid_N", "Grid_E")
hk_vehicles <- file_veh
hk_casualties <- file_cas

usethis::use_data(hk_accidents, overwrite = TRUE)
usethis::use_data(hk_vehicles, overwrite = TRUE)
usethis::use_data(hk_casualties, overwrite = TRUE)

