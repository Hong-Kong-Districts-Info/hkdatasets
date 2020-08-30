library(dplyr)
library(purrr)
library(janitor)
library(tidyr)
library(googlesheets4)

sheet_url <- "https://docs.google.com/spreadsheets/d/1007RLMHSukSJ5OfCcDJdnJW5QMZyS2P-81fe7utCZwk/"
source('.development/func_clean_gsheet_data.R')

# authorise Google account via prompt
gs4_auth()

# define google sheets ----------------------------------------------------
dc_sheet_names <- sheet_names(sheet_url)

# Exclude sheets that are named 'Master' or 'DistrictCouncilKeys'
# Leaving only sheets which are related to each DC
dc_sheet_names2 <- dc_sheet_names[!grepl(x = dc_sheet_names, pattern = "^Master$|^DistrictCouncilKey$")]

# read each sheet into a df contained in a list
list_arguments <- list(sheet = dc_sheet_names2)
list_data <- pmap(.l = list_arguments, .f = read_sheet, ss = sheet_url)
names(list_data) <- paste0("data_master_", make_clean_names(dc_sheet_names2))

# Read in DistrictCouncilKey separately
dc_key_sheet <- read_sheet(ss = sheet_url, sheet = "DistrictCouncilKey")

# Clean District Council Key sheet ----------------------------------------

dc_key <-
  dc_key_sheet %>%
  mutate(Region = paste(Region_ZH, "/", Region_EN),
         District = paste(District_ZH, "/", District_EN))


# bind list and assign to master ------------------------------------------

master_sheet <-
  list_data %>%
  map(.f = func_clean_gsheet_data) %>%
  bind_rows() %>%
  mutate(Code = substr(ConstituencyCode, start = 1, stop = 1)) %>%
  left_join(dc_key, by = "Code") %>%
  select(-Code)


# add iframe to master sheet ----------------------------------------------
chunk1 <- '<iframe src="https://www.facebook.com/plugins/page.php?href='
chunk3 <- '&tabs=timeline&width=400&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=3131730406906292" width="400" height="500" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe>'

master_sheet <-
  master_sheet %>%
  mutate(iframe = paste(chunk1, facebook, chunk3))

# Write to sheet ----------------------------------------------------------
googlesheets4::range_write(ss = sheet_url,
                           sheet = "Master",
                           data = master_sheet)
