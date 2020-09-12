# Load packages-----------------------------------------------------------------
library(tidyverse)
library(here)
library(hkdatasets)

# Read data---------------------------------------------------------------------
load(here("data", "hk_casualties.rda"))

# Add description to categorical variables--------------------------------------
hk_casualties <- hk_casualties %>%
  mutate(Casualty_Sex = case_when(
    Casualty_Sex == 1 ~ "Male",
    Casualty_Sex == 2 ~ "Female",
    TRUE ~ "Not known"
  )) %>%
  mutate(Degree_of_Injury = case_when(
    Degree_of_Injury == 1 ~ "Killed",
    Degree_of_Injury == 2 ~ "Seriously Injured",
    TRUE ~ "Slightly Injured"
  )) %>%
  mutate(Role_of_Casualty = case_when(
    Role_of_Casualty == 1 ~ "Driver",
    Role_of_Casualty == 2 ~ "Passenger",
    TRUE ~ "Pedestrian"
  )) %>%
  mutate(Location_of_Injury_Head = case_when(
    str_detect(Location_of_Injury, "NA") ~ "Not known",
    str_detect(Location_of_Injury, "A") ~ "Yes",
    TRUE ~ "No"
  )) %>%
  mutate(Location_of_Injury_Upper_trunk = case_when(
    str_detect(Location_of_Injury, "NA") ~ "Not known",
    str_detect(Location_of_Injury, "B") ~ "Yes",
    TRUE ~ "No"
  )) %>%
  mutate(Location_of_Injury_Lower_trunk = case_when(
    str_detect(Location_of_Injury, "NA") ~ "Not known",
    str_detect(Location_of_Injury, "C") ~ "Yes",
    TRUE ~ "No"
  )) %>%
  mutate(Location_of_Injury_Arms = case_when(
    str_detect(Location_of_Injury, "NA") ~ "Not known",
    str_detect(Location_of_Injury, "D") ~ "Yes",
    TRUE ~ "No"
  )) %>%
  mutate(Location_of_Injury_Legs = case_when(
    str_detect(Location_of_Injury, "NA") ~ "Not known",
    str_detect(Location_of_Injury, "E") ~ "Yes",
    TRUE ~ "No"
  )) %>%
  relocate(Location_of_Injury_Head:Location_of_Injury_Legs, .after = Location_of_Injury) %>%
  select(-Location_of_Injury) %>%
  mutate(Pedestrian_Action = case_when(
    Pedestrian_Action == 1 ~ "Walking - back to traffic",
    Pedestrian_Action == 2 ~ "Walking - facing traffic",
    Pedestrian_Action == 3 ~ "Standing",
    Pedestrian_Action == 4 ~ "Boarding vehicle",
    Pedestrian_Action == 5 ~ "Alighting from vehicle",
    Pedestrian_Action == 6 ~ "Falling or jumping from vehicle",
    Pedestrian_Action == 7 ~ "Working at a vehicle",
    Pedestrian_Action == 8 ~ "Other working",
    Pedestrian_Action == 9 ~ "Playing",
    Pedestrian_Action == 10 ~ "Crossing from near-side",
    Pedestrian_Action == 11 ~ "Crossing from off-side",
    Pedestrian_Action == 99 ~ "Not known",
    TRUE ~ "Not Applicable (i.e. non-pedestrian)"
  )) %>%
  mutate(Vehicle_Class_of_Driver_or_Pass = case_when(
    Vehicle_Class_of_Driver_or_Pass == 1 ~ "Motorcycle",
    Vehicle_Class_of_Driver_or_Pass == 2 ~ "Private car",
    Vehicle_Class_of_Driver_or_Pass == 3 ~ "Public light bus",
    Vehicle_Class_of_Driver_or_Pass == 4 ~ "Light goods vehicle",
    Vehicle_Class_of_Driver_or_Pass == 5 ~ "Medium goods vehicle",
    Vehicle_Class_of_Driver_or_Pass == 6 ~ "Heavy goods vehicle",
    Vehicle_Class_of_Driver_or_Pass == 7 ~ "Public franchised bus",
    Vehicle_Class_of_Driver_or_Pass == 8 ~ "Public non-franchised bus",
    Vehicle_Class_of_Driver_or_Pass == 9 ~ "Taxi",
    Vehicle_Class_of_Driver_or_Pass == 10 ~ "Bicycle",
    Vehicle_Class_of_Driver_or_Pass == 11 ~ "Tram",
    Vehicle_Class_of_Driver_or_Pass == 12 ~ "Light rail vehicle",
    Vehicle_Class_of_Driver_or_Pass == 13 ~ "Others (incl. unknown)",
    Vehicle_Class_of_Driver_or_Pass == "NA" ~ "Not Applicable (i.e. non-driver and non-passenger)",
    TRUE ~ "NA"
  ))

# Save updated dataset------------------------------------------------------------------
usethis::use_data(hk_casualties, overwrite = TRUE)
