# load wrangle packages ---------------------------------------------------
library(tidyverse)
library(readxl)
library(here)
library(hkdatasets)

# load data ---------------------------------------------------------------

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

# vehicles check ----------------------------------------------------------

hk_vehicles_new %>% glimpse()
hkdatasets::hk_vehicles %>% glimpse()

setdiff(names(hk_vehicles_new), names(hkdatasets::hk_vehicles))
setdiff(names(hkdatasets::hk_vehicles), names(hk_vehicles_new))

# comparison notes --------------------------------------------------------
#' 1. both datasets have same number of rows.
#' 2. new dataset has 8 additional columns. Two of those can be ignored,
#' as they are prefixed with X (original checking columns), namely `X_Vehicle_`
#' and `X_Duplicat`.
#' 3. old dataset has an additional `OBJECTID` column corresponding to the
#' row number.
#' 3. common columns (new - old)
#'  - `Serial_No_`
#'  - `Year`
#'  - `Vehicle_Cl` - `Vehicle_Class`
#'  - `Severity_o` - `Severity_of_Accident`
#'  - `Driver_Age`
#'  - `Driver_Sex`
#'  - `X_Year_of_` - `Year_of_Manufacture`
#'  
#' 4. new columns (new)
#'  - `Vehicle_co`
#'  - `First_poin`
#'  - `Main_vehic`
#'  - `Grid_E`
#'  - `Grid_N`
#'  - `Pedal_cycl`
#'  - `Pedal_col`

# check old and new are row-by-row matches --------------------------------

data.frame(
  old = hk_vehicles$Serial_No_,
  new = hk_vehicles_new$Serial_No_
  ) %>%
  mutate(IsSame = (old == new)) %>%
  filter(IsSame == FALSE)

## not true

# create unique row IDs ---------------------------------------------------

hk_vehicles_new %>%
  mutate(UniqueID = paste(
    Serial_No_,
    Year,
    Driver_Age,
    Driver_Sex,
    X_Year_of_,
    Vehicle_Cl,
    Severity_o
    ),
    sep = "-") %>%
  summarise(
    nd_UniqueID = n_distinct(UniqueID),
    nrow = nrow(.)
  )

# using all unique columns do not yield a unique ID

hk_vehicles_new %>%
  mutate(IsDup = duplicated(.)) %>%
  filter(IsDup == TRUE)
  
# There are 186 rows that are duplicated in the new data. 

# FINAL APPROACH:
# Clean dataset from scratch to prevent mismatch
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

# interactive tests -------------------------------------------------------

table(hk_vehicles_new$Main_vehic) # Main vehicle manouvre
table(hk_vehicles_new$Vehicle_co) # Vehicle collision with
table(hk_vehicles_new$First_poin) # First point of impact

# Cleaning new dataset ----------------------------------------------------
# TODO: `Pedal_col` left out 

hk_vehicles_new_cleaned_labelled <-
  hk_vehicles_new %>%
  
  # create OBJECTID ----------------------------------------------
  mutate(OBJECTID = 1:nrow(.)) %>%
  select(OBJECTID, everything()) %>%
  
  # rename columns -----------------------------------------------
  rename(
    Vehicle_Class = "Vehicle_Cl",
    Severity_of_Accident = "Severity_o",
    Year_of_Manufacture = "X_Year_of_",
    Vehicle_Collision = "Vehicle_co",
    First_point = "First_poin",
    Main_vehicle = "Main_vehic",
    Pedal_cycle = "Pedal_cycl"
  ) %>%
  
  # labels -------------------------------------------------------
  mutate(
    Vehicle_Class = look_up(Vehicle_Class, dictionary = t_Vehicle_Class),
    Severity_of_Accident = look_up(Severity_of_Accident, dictionary = t_Sev_of),
    Vehicle_Collision = look_up(Vehicle_Collision, dictionary = t_Vehicle_co),
    First_point = look_up(First_point, dictionary = t_First_poin),
    Main_vehicle = look_up(Main_vehicle, dictionary = t_Main_vehic),
    Pedal_cycle = look_up(Pedal_cycle, dictionary = t_Ped_Cycle),
    Driver_Sex = case_when(
      Driver_Sex == 1 ~ "Male",
      Driver_Sex == 2 ~ "Female",
      Driver_Sex == 9 ~ "Not known"),
    ) %>%
    # Pedal_col = look_up(Pedal_col, dictionary = t_Ped_Cycle)
  
  
  # variable type ------------------------------------------------
  
  mutate(Year_of_Manufacture = as.character(Year_of_Manufacture)) %>%
  mutate(Driver_Age = ifelse(
    Driver_Age == 999, NA, Driver_Age
  )) %>%
  
  # Remove unneeded columns --------------------------------------
  select(
    -Pedal_col,
    -X_Vehicle_,
    -X_Duplicat
    )


# Interactive checks -------------------------------------------------------

hk_vehicles_new_cleaned_labelled %>% glimpse()
hk_vehicles_new_cleaned_labelled %>% summary()
hk_vehicles_new_cleaned_labelled %>% skimr::skim()

# Overwrite dataset for hk_vehicles --------------------------------------- 

hk_vehicles <- hk_vehicles_new_cleaned_labelled # overwrite
usethis::use_data(hk_vehicles, overwrite = TRUE)

