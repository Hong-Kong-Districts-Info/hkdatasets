#' @title Download and Extract data from online sources
#'
#' @description Download and extract data from preset online sources, specifying
#' the name of the dataset. 
#' 
#' @details This supersedes the method for pulling `hk_accidents` due to the
#'   size of the data file.
#'
#' @param dataset String containing the name of the dataset. Valid values
#'   include:
#'     - `"hk_accidents"`
#'     - `"hk_casualties"`
#'     - `"hk_vehicles"`
#'     
#' @importFrom fst read_fst
#' 
#' @return A data frame is returned. 
#' 
#' @section Example:
#' You can download and return a dataset with the following code:
#' ```
#' download_data(dataset = "hk_vehicles")
#' ```
#' 
#' @export   
download_data <- function(dataset = NULL){
  
  if(is.null(dataset)){
    
    stop("please provide the name of the dataset to pull.")
    
  }
  
  pull_url <- paste0(
    "https://github.com/",
    "Hong-Kong-Districts-Info/",
    "hkdatasets/",
    "raw/master/data-ready/",
    dataset,
    ".fst"
  )
  
  # create a temporary directory
  td <- tempdir()
  
  # create the placeholder file
  tf <- tempfile(tmpdir = td, fileext = ".fst")
  
  # download into the placeholder file
  utils::download.file(
    url = pull_url,
    destfile = tf,
    quiet = TRUE,
    mode = "wb" # binary
    )
  
  fst::read_fst(tf)
}