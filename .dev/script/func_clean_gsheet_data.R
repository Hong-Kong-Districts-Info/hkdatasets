# clean googlesheets ------------------------------------------------------
library(janitor)
library(tidyr)
library(dplyr)

func_clean_gsheet_data <- function(data){
  data %>%
    clean_names() %>%
    separate(col = xuan_qu_constituency, into = c("Constituency_ZH", "Constituency_EN"), sep = "\n", extra = "merge") %>%
    separate(col = dang_pai_party, into = c("Party_ZH", "Party_EN"), sep = "\n", extra = "merge") %>%
    separate(col = qu_yi_yuan_dc, into = c("DC_ZH", "DC_EN"), sep = "\n", extra = "merge") %>%
    rename(ConstituencyCode = "xuan_qu_hao_ma_constituency_code") %>%
    mutate(DropDownText = paste0(ConstituencyCode, ": ", Constituency_ZH, " / ", Constituency_EN),
           Party = paste(Party_ZH, "/", Party_EN),
           DC = paste(DC_ZH, "/", DC_EN))
}