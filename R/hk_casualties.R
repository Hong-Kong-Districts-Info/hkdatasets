#' Dataset of casualties involved in collisions between 2014 and 2019.
#'
#' A dataset containing information of collisions by casualties between 2014
#' and 2019.
#'
#' @format A data frame with 120110 rows and 20 variables:
#' \describe{
#'   \item{OBJECTID}{Numeric. Identifier for the row.}
#'   \item{Year}{Numeric. Year in which incident has occurred.}
#'   \item{Serial_No_}{Numeric. Serial number for cross-matching with data
#'   between `hk_accidents`, `hk_casualties` and `hk_vehicles`.}
#'   \item{Casualty_Age}{Numeric.}
#'   \item{Casualty_Sex}{Character.}
#'   \item{Degree_of_Injury}{Character.}
#'   \item{Role_of_Casualty}{Character.}
#'   \item{Location_of_Injury_Head}{Logical.}
#'   \item{Location_of_Injury_Upper_trunk}{Logical.}
#'   \item{Location_of_Injury_Lower_trunk}{Logical.}
#'   \item{Location_of_Injury_Arms}{Logical.}
#'   \item{Location_of_Injury_Legs}{Logical.}
#'   \item{Pedestrian_Action}{Character.}
#'   \item{Vehicle_Class_of_Driver_or_Pass}{Character.}
#'   \item{Ped_Action}{Character.}
#'   \item{Ped_Location}{Character.}
#'   \item{Ped_Circumstances}{Character.}
#'   \item{Grid_E}{Numeric. Eastings as per the 1980 Hong Kong Grid System.}
#'   \item{Grid_N}{Numeric. Northings as per the 1980 Hong Kong Grid System.}
#'   \item{Pedal_cycle}{Character.}
#'   ...
#' }
#' @source \url{https://www.td.gov.hk/}
"hk_casualties"