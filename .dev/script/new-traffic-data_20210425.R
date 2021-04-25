library(tidyverse)
library(readxl)
library(here)
library(dataCompareR)

# load data ---------------------------------------------------------------

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

# dataCompareR ------------------------------------------------------------

# hk_accidents
compare_acc <-
  dataCompareR::rCompare(
    dfA = hk_accidents,
    dfB = hk_accidents_new
  )

compare_acc %>%
  saveReport(
    paste("Comparison of hk_accidents old and new", wpa::tstamp())
  )

# hk_casualties
compare_cas <-
  dataCompareR::rCompare(
    dfA = hk_casualties,
    dfB = hk_casualties_new
  )

compare_cas %>%
  saveReport(
    paste("Comparison of hk_casualties old and new", wpa::tstamp())
    )

# hk_vehicles
compare_veh <-
  dataCompareR::rCompare(
    dfA = hk_vehicles,
    dfB = hk_vehicles_new
  )

compare_veh %>%
  saveReport(
    paste("Comparison of hk_vehicles old and new", wpa::tstamp())
  )

# data clean --------------------------------------------------------------
# this chunk does two things:
# 1. join new variables up to the old datasets
# 2. "code" new variables as factor / categorical variables

hk_accidents_new_cleaned <-
  hk_accidents %>%
  left_join(
    # New columns
    select(
      hk_accidents_new,
      
      # variables for joining ---------------------------------------
      Date, # For joining
      Serial_No_, # For joining
      Year, # For joining
      
      # FIXME: New variables with code frames missing - what are these?
      Pedal_cycl, 
      Pedal_col, 
      TypeOfCo_P, 
      Struc_Type, 
      RD_Class_L, 
      
      # New variables with code frames identified -------------------
      
      Street_nam, # Street name, need to be joined with A1
      Within_70m, # Whether within 70m of junction
      Second_str, # Second street name, need to be joined with A1
      Road_type_, # E.g. One way, Two way, Dual carriageway
      Road_class, # Slightly different from `Road_Classification`
      Overtaking, # E.g. One vehicle, two or more, etc. 
      ),
    by = c("Date", "Serial_No_", "Year")
  )
  
# interactive tests

table(hk_accidents$Road_Classification)
table(hk_accidents_new$RD_Class_L)
table(hk_accidents_new$Road_class) # Slightly different from Road Classification
table(hk_accidents_new$Road_type_) # Road type - completely new

table(hk_vehicles_new$Main_vehic) # Main vehicle manouvre
table(hk_vehicles_new$Vehicle_co) # Vehicle collision with
table(hk_vehicles_new$First_poin) # First point of impact

table(hk_casualties_new$Pedestri_1) # Pedestrian location
table(hk_casualties_new$Pedestri_2) # Pedestrian special circumstances
table(hk_casualties_new$Pedestrian) # Pedestrian action
table(hk_casualties_new$X_Pedestri) # ???



