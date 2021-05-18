library(tidyverse)
library(readxl)
library(here)
library(hkdatasets)
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

# labels for matching up to new data
# read each individual data frame to global environment
code_sheets_path <-
  here("data-raw",
       "reformatted_Code table_v1.xlsx")

code_sheets <- excel_sheets(code_sheets_path)

code_sheets %>%
  purrr::map(function(sheet){ # iterate through each sheet name
    assign(x = paste0("t_", sheet), # prefixed variable names
           value = readxl::read_xlsx(path = code_sheets_path, sheet = sheet),
           envir = .GlobalEnv)
  })

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

look_up <- function(x,
                    dictionary,
                    index = "Code",
                    match = "Description"){
  dictionary[[match]][c(match(x, dictionary[[index]]))]
}

# look_up(iris$Species,
#         c("virginica", "versicolor", "setosa"),
#         replace = c("tum", "de", "da"))

hk_accidents_new_cleaned_unlabelled <-
  hk_accidents %>%
  left_join(
    # New columns
    select(
      hk_accidents_new,
      
      # variables for joining ---------------------------------------
      Date, # For joining
      Serial_No_, # For joining
      Year, # For joining
      
      # New variables with code frames identified --------------------
      Street_nam, # Street name, need to be joined with A1_street_name
      Second_str, # Second street name, need to be joined with A1_street_name
      Overtaking, # E.g. One vehicle, two or more, etc.
      Within_70m, # Whether within 70m of junction
      Road_type_, # E.g. One way, Two way, Dual carriageway
      Pedal_cycl, # Others, Pedal Cycle, Motorcycle
      TypeOfCo_P, # E.g. Vehicle collision with Pedestrian, etc.
      Struc_Type, # E.g. At grade road, Flyover, Bridge, etc.
      RD_Class_L, # E.g. Expressway, Main Road, Secondary Road, etc.
      Road_class, # Slightly different from `Road_Classification`
      
      # New variables that do not require code frame -----------------
      Precise_lo, # Precise location. Strength.
      Accident_a, # No/ Yes
      Junction_t, # E.g. Cross roads, T-junction, Y-junction, Multiple, etc.
      Whether_at, # E.g. No crossing control, On a crossing control, etc.
      Type_of_Cr, # E.g. Footbridge/Subway, Traffic signal, Zebra, etc.
      
      ),
    by = c("Date", "Serial_No_", "Year")
  )
  
  # labelling ----------------------------------------------------------------

hk_accidents_new_cleaned_labelled <-
  hk_accidents_new_cleaned_unlabelled %>%
mutate(
  Street_Name = look_up(Street_nam, dictionary = t_A1_street_name),
  Overtaking = look_up(Overtaking, dictionary = t_Overtaking),
  Within_70m = look_up(Within_70m, dictionary =  t_Within_70m),
  Road_Type = look_up(Road_type_, dictionary = t_Road_type_),
  Cycle_Type = look_up(Pedal_cycl, dictionary = t_Ped_Cycle),
  Type_of_Collision_v2 = look_up(TypeOfCo_P, dictionary = t_Collision_Type),
  Structure_Type = look_up(Struc_Type, dictionary = t_Struc_Type),
  Road_Class_L = look_up(RD_Class_L, dictionary = t_Road_class_L),
  Road_Classification_v2 = look_up(Road_class, dictionary = t_Road_class)
) %>%
  
  # Remove old names ------------------------------------------------------
  select( 
    -Street_nam,
    -Second_str,
    -Road_type_,
    -Pedal_cycl,
    -TypeOfCo_P,
    -Struc_Type,
    -RD_Class_L,
    -Road_class
  ) %>%
  
  # Rename new variables --------------------------------------------------
  rename(Precise_Location = "Precise_lo") %>%
  rename(Accident = "Accident_a") %>%
  rename(Junction_Type = "Junction_t") %>%
  rename(Crossing_Control = "Whether_at") %>%
  rename(Crossing_Type = "Type_of_Cr") %>%
  rename(Type_of_Collision_with_cycle = "Type_of_Collision_v2") %>%
  rename(Road_Hierarchy = "Road_Class_L") %>%

  # Rename rows with value "n.a." to "NA" ---------------------------------
  mutate(Junction_Type = case_when(Junction_Type == "n.a." ~ "NA",
                                   TRUE ~ Junction_Type)) %>%
  mutate(Crossing_Type = case_when(Crossing_Type == "n.a." ~ "NA",
                                 TRUE ~ Junction_Type)) %>%
  mutate(Road_Hierarchy = ifelse(Road_Hierarchy == "N.A.", NA, Road_Hierarchy))
  # Replace old Road Classification with new ------------------------------
  select(-Road_Classification) %>%
  rename(Road_Classification = "Road_Classification_v2") %>%
  rename(Road_Ownership = "Road_Classification") %>%
  
  # Final variable name cleaning ------------------------------------------
  rename(No_of_Vehicles_Involved = "No__of_Vehicles_Involved",
         No_of_Casualties_Injured = "No__of_Casualties_Injured")
  


# interactive tests -------------------------------------------------------

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


# Additional cleaning 17 May 2021 ------------------------------------------

hk_accidents_new_cleaned_labelled %>% glimpse()
hk_accidents <- hk_accidents_new_cleaned_labelled # overwrite
usethis::use_data(hk_accidents, overwrite = TRUE)
