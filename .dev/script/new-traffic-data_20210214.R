library(tidyverse)
library(readxl)
library(here)

hk_accidents_new <-
  read_xlsx(
    here("data-raw",
         "FurtherData_Accident20142019_joined_210201.xlsx"))

hk_casualties_new <-
  read_xlsx(
    here("data-raw",
         "FurtherData_Casualty20142019_Joined_201216.xlsx"))

hk_vehicles_new <-
  read_xlsx(
    here("data-raw",
         "FurtherData_Vehicle20142019_Joined_201216.xlsx"))


# accidents check ---------------------------------------------------------

hk_accidents_new %>% glimpse()
hkdatasets::hk_accidents %>% glimpse()

setdiff(names(hk_accidents_new), names(hkdatasets::hk_accidents))
setdiff(names(hkdatasets::hk_accidents), names(hk_accidents_new))


# casualties check --------------------------------------------------------

hk_casualties_new %>% glimpse()
hkdatasets::hk_casualties %>% glimpse()

setdiff(names(hk_casualties_new), names(hkdatasets::hk_casualties))
setdiff(names(hkdatasets::hk_casualties), names(hk_casualties_new))


# vehicles check ----------------------------------------------------------

hk_vehicles_new %>% glimpse()
hkdatasets::hk_vehicles %>% glimpse()

setdiff(names(hk_vehicles_new), names(hkdatasets::hk_vehicles))
setdiff(names(hkdatasets::hk_vehicles), names(hk_vehicles_new))



