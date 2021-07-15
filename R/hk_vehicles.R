#' Dataset of vehicles involved in collisions between 2014 and 2019.
#'
#' A dataset containing information of collisions by vehicles between 2014
#' and 2019.
#'
#' @format A data frame with 153062 rows and 14 variables:
#' \describe{
#'   \item{OBJECTID}{Numeric. Identifier for the row.}
#'   \item{Serial_No_}{Numeric. Serial number for cross-matching with data
#'   between `hk_accidents`, `hk_casualties` and `hk_vehicles`.}
#'   \item{Year}{Numeric. Year in which incident has occurred.}
#'   \item{Vehicle_Class}{}
#'   \item{Vehicle_Collision}{}
#'   \item{First_point}{}
#'   \item{Severity_of_Accident}{}
#'   \item{Driver_Age}{}
#'   \item{Driver_Sex}{}
#'   \item{Main_vehicle}{}
#'   \item{Year_of_Manufacture}{}
#'   \item{Grid_E}{}
#'   \item{Grid_N}{}
#'   \item{Pedal_cycle}{}
#'   ...
#' }
#' @source \url{https://www.td.gov.hk/}
"hk_vehicles"