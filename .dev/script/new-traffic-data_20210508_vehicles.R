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


# dataCompareR ------------------------------------------------------------

# # hk_vehicles
# compare_veh <-
#   dataCompareR::rCompare(
#     dfA = hk_vehicles,
#     dfB = hk_vehicles_new
#   )
# 
# compare_veh %>%
#   saveReport(
#     paste("Comparison of hk_vehicles old and new", wpa::tstamp())
#   )

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

