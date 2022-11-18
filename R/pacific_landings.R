#' Catch data from the vessels in Mexico
#'
#' A `data.frame` object containing catch data per each vessel from 2015 to 2020
#'
#' @format A `data.frame`  with 111,369 rows and 7 columns
#' \describe{
#'   \item{date}{Date of the catch report}
#'   \item{rnp_activo}{Vessel RNP unique ID code}
#'   \item{vessel_name}{Official name of the vessel}
#'   \item{catch}{Final weight of the catch in tons}
#'   \item{days_declared}{Days at sea that were declared at port}
#'   ...
#' }
#' @source Data are available under request to CONAPESCA, a raw version of data is available under request to authors

"landings"
