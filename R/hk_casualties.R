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
#'   \item{Casualty_Age}{}
#'   \item{Casualty_Sex}{}
#'   \item{Degree_of_Injury}{}
#'   \item{Role_of_Casualty}{}
#'   \item{Location_of_Injury_Head}{}
#'   \item{Location_of_Injury_Upper_trunk}{}
#'   \item{Location_of_Injury_Lower_trunk}{}
#'   \item{Location_of_Injury_Arms}{}
#'   \item{Location_of_Injury_Legs}{}
#'   \item{Pedestrian_Action}{}
#'   \item{Vehicle_Class_of_Driver_or_Pass}{}
#'   \item{Ped_Action}{}
#'   \item{Ped_Location}{}
#'   \item{Ped_Circumstances}{}
#'   \item{Grid_E}{}
#'   \item{Grid_N}{}
#'   \item{Pedal_cycle}{}
#'   ...
#' }
#' @source \url{https://www.td.gov.hk/}
"hk_casualties"