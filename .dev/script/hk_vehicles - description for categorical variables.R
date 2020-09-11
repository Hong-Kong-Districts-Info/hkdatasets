# Load packages-----------------------------------------------------------------
library(tidyverse)
library(here)
library(hkdatasets)

# Read data---------------------------------------------------------------------
load(here("data", "hk_vehicles.rda"))

# Add description to categorical variables--------------------------------------
hk_vehicles <- hk_vehicles %>%
  mutate(Driver_Sex = case_when(
    Driver_Sex == 1 ~ "Male",
    Driver_Sex == 2 ~ "Female",
    TRUE ~ "Not known"
  )) %>%
  mutate(Severity_of_Accident = case_when(
    Severity_of_Accident == 1 ~ "Fatal",
    Severity_of_Accident == 2 ~ "Serious",
    TRUE ~ "Slight"
  )) %>%
  mutate(Vehicle_Class = case_when(
    Vehicle_Class == 1 ~ "Motorcycle",
    Vehicle_Class == 2 ~ "Private car",
    Vehicle_Class == 3 ~ "Public light bus",
    Vehicle_Class == 4 ~ "Light goods vehicle",
    Vehicle_Class == 5 ~ "Medium goods vehicle",
    Vehicle_Class == 6 ~ "Heavy goods vehicle",
    Vehicle_Class == 7 ~ "Public franchised bus",
    Vehicle_Class == 8 ~ "Public non-franchised bus",
    Vehicle_Class == 9 ~ "Taxi",
    Vehicle_Class == 10 ~ "Bicycle",
    Vehicle_Class == 11 ~ "Tram",
    Vehicle_Class == 12 ~ "Light rail vehicle",
    TRUE ~ "Others (incl. unknown)"
  ))

# Save updated dataset------------------------------------------------------------------
usethis::use_data(hk_vehicles, overwrite = TRUE)