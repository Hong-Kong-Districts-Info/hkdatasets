library(testthat)

context(desc = "Testing clean_gsheet_data() function")

test_that("testing `clean_gsheet_data()` expected outcomes", {
  
  # create dummy data for testing
  df <- data.frame(
    xuan_qu_hao_ma_constituency_code = c("A-69", "X-99", "S-33"),
    `選區 \nConstituency` = c("天后\nTIN HAU", "富榮\nCHARMING", "樂民\nLOK MAN"),
    `黨派\nParty` = c("經民聯\nBusiness and Professionals Alliance for Hong Kong",
                    "公屋聯會\nFederation of Public Housing Estate",
                    "屯門社區網絡\nTuen Mun Community Network"),
    `區議員\nDC` = c("梁銘康\nLEUNG MING HONG",
                  "莫灝哲\nMOK KIN WING",
                  "林浩波\nLAM HO POR KELVIN"),
    stringsAsFactors = FALSE
  )
  
  # create expected result
  pass_expected <- data.frame(
    ConstituencyCode = c("A-69", "X-99", "S-33"),
    Constituency_ZH = c("天后", "富榮", "樂民"),
    Constituency_EN = c("TIN HAU", "CHARMING", "LOK MAN"),
    Party_ZH = c("經民聯", "公屋聯會", "屯門社區網絡"),
    Party_EN = c("Business and Professionals Alliance for Hong Kong",
                 "Federation of Public Housing Estate",
                 "Tuen Mun Community Network"),
    DC_ZH = c("梁銘康", "莫灝哲", "林浩波"),
    DC_EN = c("LEUNG MING HONG", "MOK KIN WING", "LAM HO POR KELVIN"),
    DropDownText = c("A-69: 天后 / TIN HAU", 
                     "X-99: 富榮 / CHARMING",
                     "S-33: 樂民 / LOK MAN"),
    Party = c("經民聯 / Business and Professionals Alliance for Hong Kong",
              "公屋聯會 / Federation of Public Housing Estate",
              "屯門社區網絡 / Tuen Mun Community Network"),
    DC = c("梁銘康 / LEUNG MING HONG", "莫灝哲 / MOK KIN WING", "林浩波 / LAM HO POR KELVIN"),
    stringsAsFactors = FALSE
  )
  
  expect_equal(object = clean_gsheet_data(df), 
               expected = pass_expected)
})