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
#'   \item{Vehicle_Class}{Character.}
#'   \item{Vehicle_Collision}{Character.}
#'   \item{First_point}{Character.}
#'   \item{Severity_of_Accident}{Character. Indicates the severity of the
#'   accident. Can be 'Fatal', 'Serious', or 'Slight'.}
#'   \item{Driver_Age}{Numeric. Indicates the age of the driver.}
#'   \item{Driver_Sex}{Character. Indicates the sex of the driver.}
#'   \item{Main_vehicle}{Character.}
#'   \item{Year_of_Manufacture}{Character.}
#'   \item{Grid_E}{Double.}
#'   \item{Grid_N}{Double.}
#'   \item{Pedal_cycle}{Character.}
#'   ...
#' }
#' @source \url{https://www.td.gov.hk/}
"hk_vehicles"