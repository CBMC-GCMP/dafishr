#' Catch data from the vessels in Mexico
#'
#' A `data.frame` object containing catch data per each vessel from 2001 to 2021.
#' Vessels are only from the Pacific and are only Tuna, Sharks, and Marlin catches.
#' The dataset was created by wrangling and filtering the raw data (available under request to the authors).
#'
#' @format A `data.frame`  with 33,130 rows and 5 columns
#' \describe{
#'   \item{date}{Date of the catch report}
#'   \item{rnp_activo}{Vessel RNP unique ID code}
#'   \item{vessel_name}{Official name of the vessel}
#'   \item{catch}{Final weight of the catch in tons}
#'   \item{days_declared}{Days at sea that were declared at port}
#'   ...
#' }
#' @source Data are available under request to CONAPESCA, a raw version of data is available under request to authors

"pacific_landings"
