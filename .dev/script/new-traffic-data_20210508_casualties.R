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
# code_sheets_path <-
#   here("data-raw",
#        "reformatted_Code table_v1.xlsx")
# 
# code_sheets <- excel_sheets(code_sheets_path)
# 
# code_sheets %>%
#   purrr::map(function(sheet){ # iterate through each sheet name
#     assign(x = paste0("t_", sheet), # prefixed variable names
#            value = readxl::read_xlsx(path = code_sheets_path, sheet = sheet),
#            envir = .GlobalEnv)
#   })

# casualties check --------------------------------------------------------

# hk_casualties_new %>% glimpse()
# hkdatasets::hk_casualties %>% glimpse()
# 
# setdiff(names(hk_casualties_new), names(hkdatasets::hk_casualties))
# setdiff(names(hkdatasets::hk_casualties), names(hk_casualties_new))

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

hk_casualties_new_cleaned_unlabelled <-
  hk_casualties %>%
  left_join(
    # New columns
    select(
      hk_casualties_new,
      
      # variables for joining ---------------------------------------
      Serial_No_, # For joining
      Year, # For joining
      
      # New variables with code frames identified --------------------
      Casualty_A,
      Casualty_S,
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
    ),
    by = c("Serial_No_", "Year")
  )

hk_casualties_new_cleaned_labelled <-
  hk_casualties_new_cleaned_unlabelled %>%
  
  # To logical 
  mutate(
    across(
      .cols = starts_with("Location_of_Injury_"),
      .fns = ~ifelse(. == "Yes", TRUE, FALSE)
    )
  )

glimpse(hk_casualties_new_cleaned_labelled)

# interactive tests -------------------------------------------------------

table(hk_casualties_new$Pedestri_1) # Pedestrian location
table(hk_casualties_new$Pedestri_2) # Pedestrian special circumstances
table(hk_casualties_new$Pedestrian) # Pedestrian action
table(hk_casualties_new$X_Pedestri) # ???
