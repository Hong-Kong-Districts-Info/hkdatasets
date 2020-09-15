# Load packages-----------------------------------------------------------------
library(tidyverse)
library(here)
library(hkdatasets)

# Read data---------------------------------------------------------------------
load(here("data", "hk_accidents.rda"))

# Add description to categorical variables--------------------------------------
hk_accidents <- hk_accidents %>%
  mutate(Severity = case_when(
    Severity == 1 ~ "Fatal",
    Severity == 2 ~ "Serious",
    TRUE ~ "Slight"
  )) %>%
  mutate(Hit_and_Run = case_when(
    Hit_and_Run == 1 ~ "Yes",
    TRUE ~ "No"
  )) %>%
  mutate(Weather = case_when(
    Weather == 1 ~ "Clear",
    Weather == 2 ~ "Dull",
    Weather == 3 ~ "Fog/mist",
    Weather == 4 ~ "Strong wind",
    TRUE ~ "Not known"
  )) %>%
  mutate(Rain = case_when(
    Rain == 1 ~ "Not raining",
    Rain == 2 ~ "Light rain",
    Rain == 3 ~ "Heavy rain",
    TRUE ~ "Not known"
  )) %>%
  mutate(Natural_Light = case_when(
    Natural_Light == 1 ~ "Daylight",
    Natural_Light == 2 ~ "Dawn/Dusk",
    Natural_Light == 3 ~ "Dark",
    TRUE ~ "Not known"
  )) %>%
  mutate(Junction_Control = case_when(
    Junction_Control == 1 ~ "No control",
    Junction_Control == 2 ~ "Stop (halt)",
    Junction_Control == 3 ~ "Give way (slow)",
    Junction_Control == 4 ~ "Traffic signal",
    Junction_Control == 5 ~ "Police",
    Junction_Control == 6 ~ "Not junction",
    TRUE ~ "NA"
  )) %>%
  mutate(Road_Classification = case_when(
    Road_Classification == 1 ~ "Private road",
    Road_Classification == 2 ~ "Non-private road",
    TRUE ~ "NA"
  )) %>%
  mutate(Vehicle_Movements = case_when(
    Vehicle_Movements == 1 ~ "One moving vehicle",
    Vehicle_Movements == 2 ~ "Two moving vehicles - from same direction",
    Vehicle_Movements == 3 ~ "Two moving vehicles - from opposite direction",
    Vehicle_Movements == 4 ~ "Two moving vehicles - from different roads",
    Vehicle_Movements == 5 ~ "> 2 moving vehicles - from same direction",
    Vehicle_Movements == 6 ~ "> 2 moving vehicles - from opposite direction",
    TRUE ~ ">2 moving vehicles - from different roads"
  )) %>%
  mutate(Type_of_Collision = case_when(
    Type_of_Collision == 1 ~ "Vehicle collision with Pedestrian",
    Type_of_Collision == 2 ~ "Vehicle collision with Vehicle",
    Type_of_Collision == 3 ~ "Vehicle collision with Object",
    TRUE ~ "Vehicle collision with Nothing"
  ))

# Save updated dataset------------------------------------------------------------------
usethis::use_data(hk_accidents, overwrite = TRUE)
