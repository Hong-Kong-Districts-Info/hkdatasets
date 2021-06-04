# load wrangle packages ---------------------------------------------------
library(tidyverse)
library(readxl)
library(here)
library(hkdatasets)
library(dataCompareR)

# load data ---------------------------------------------------------------

hk_casualties_new <-
  read_xlsx(
    here("data-raw",
         "FurtherData_Casualty20142019_Joined_201216.xlsx"))

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

# casualties check --------------------------------------------------------

# hk_casualties_new %>% glimpse()
# hkdatasets::hk_casualties %>% glimpse()
# 
# setdiff(names(hk_casualties_new), names(hkdatasets::hk_casualties))
# setdiff(names(hkdatasets::hk_casualties), names(hk_casualties_new))
# intersect(names(hkdatasets::hk_casualties), names(hk_casualties_new))

# tibble(
#   old = hk_casualties$Serial_No_,
#   new = hk_casualties_new$Serial_No_  
# ) %>%
#   mutate(equal = (old == new)) %>%
#   count(equal)
# 
# tibble(
#   old = hk_casualties$Casualty_Age,
#   new = hk_casualties_new$Casualty_A  
# ) %>%
#   mutate(equal = (old == new)) %>%
#   count(equal)

# Checks of unique identifier in `hk_casualties_new`
#
# hk_casualties_new %>%
#   mutate(ID = paste0(
#     Year,
#     Serial_No_,
#     Casualty_A,
#     Casualty_S,
#     Degree_of_
#   )) %>%
#   summarise(n = n_distinct(ID))

# NOTE:
# unique identifiers are difficult to create, so instead an `cbind()` method 
# will be used for combining the old and new datasets instead. This can be done
# more neatly by fabricating an `OBJECTID` in `hk_casualties_new`. 
# 
# Checks to be done afterwards to ensure that the old and new rows have not 
# been scrambled. 

# dataCompareR ------------------------------------------------------------

# # hk_casualties
# compare_cas <-
#   dataCompareR::rCompare(
#     dfA = hk_casualties,
#     dfB = hk_casualties_new
#   )
# 
# compare_cas %>%
#   saveReport(
#     paste("Comparison of hk_casualties old and new", wpa::tstamp())
#     )

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


# hk_casualties -----------------------------------------------------------

## interim renaming of `hk_casualties_new`
hk_casualties_new2 <-
  # New columns
  hk_casualties_new %>%
  
    # Variables for checking --------------------------------------
  select(
    Serial_No_2 = "Serial_No_", 
    Year2 = "Year", 
    Casualty_Age2 = "Casualty_A", 
    Casualty_Sex2 = "Casualty_S",
    
    # New variables with code frames identified --------------------
    Degree_of_,
    Role_of_Ca,
    Location_o,
    Vehicle_Cl,
    Pedestrian,
    Pedestri_1,
    Pedestri_2,
    Grid_E,
    Grid_N,
    X_Pedestri,
    X_Duplicat,
    Pedal_cycl
  ) %>%
  mutate(
    Casualty_Sex2 = case_when(
      Casualty_Sex2 == 1 ~ "Male",
      Casualty_Sex2 == 2 ~ "Female",
      Casualty_Sex2 == 9 ~ "Not known"),
    OBJECTID = 1:nrow(.)
  )

## join two datasets  
hk_casualties_new_cleaned_unlabelled <-
  hk_casualties %>%
  left_join(
    hk_casualties_new2,
    by = "OBJECTID"
  )

## checks
# hk_casualties_new_cleaned_unlabelled %>% glimpse()
# nrow(hk_casualties_new_cleaned_unlabelled) == nrow(hk_casualties)
# hk_casualties_new_cleaned_unlabelled %>% count(Degree_of_, Degree_of_Injury)
# hk_casualties_new_cleaned_unlabelled %>% count(Casualty_Age, Casualty_Age2)
# hk_casualties_new_cleaned_unlabelled %>% count(Casualty_Sex, Casualty_Sex2)
# hk_casualties_new_cleaned_unlabelled %>% count(Year, Year2)


hk_casualties_new_cleaned_labelled <-
  hk_casualties_new_cleaned_unlabelled %>%
  # Remove duplicates ---------------------------------------------------
  select(
    -Serial_No_2,
    -Year2,
    -Casualty_Age2,
    -Casualty_Sex2
  ) %>%
  
  # To logical -----------------------------------------------------------
  mutate(
    across(
      .cols = starts_with("Location_of_Injury_"),
      .fns = ~ifelse(. == "Yes", TRUE, FALSE)
    )
  ) %>%
  
  # More intuitive names -------------------------------------------------
  rename(
    Casualty_Sex_2 = "Casualty_Sex", # Retain for checks
    Ped_Location = "Pedestri_1",
    Ped_Circumstances = "Pedestri_2",
    Ped_Action = "Pedestrian"
  ) %>%
  
  # Labels ---------------------------------------------------------------

  mutate(
    Ped_Location = look_up(Ped_Location, dictionary = t_Ped_Location),
    Ped_Circumstances = look_up(Ped_Circumstances, dictionary = t_Ped_Special)
    # Ped_Action = look_up(Ped_Action, dictionary = t_Ped_Cycle),
  )

# interactive tests -------------------------------------------------------
glimpse(hk_casualties_new_cleaned_labelled)

table(hk_casualties_new$Pedestri_1) # Pedestrian location
table(hk_casualties_new$Pedestri_2) # Pedestrian special circumstances
table(hk_casualties_new$Pedestrian) # Pedestrian action
table(hk_casualties_new$X_Pedestri) # ???

hk_casualties_new_cleaned_labelled %>% count(Casualty_Sex, Casualty_Sex_2)
hk_casualties_new_cleaned_labelled %>% count(Casualty_Age, Casualty_Age_2)

# Overwrite dataset for hk_casualties ------------------------------------- 
glimpse(hk_casualties_new_cleaned_labelled)
skimr::skim(hk_casualties_new_cleaned_labelled)

hk_casualties <- hk_casualties_new_cleaned_labelled # overwrite
usethis::use_data(hk_casualties, overwrite = TRUE)