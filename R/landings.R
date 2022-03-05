#' Catch data from the vessels in Mexico
#'
#' A `data.frame` object containing catch data per each vessel from 2015 to 2020
#'
#' @format A `data.frame`  with 111,369 rows and 7 columns
#' \describe{
#'   \item{office_name}{Name of office where the catch was reported to}
#'   \item{year}{year when the catch was taken}
#'   \item{category}{vessel category MENORES = artesanal vessels, MAYORES = industrial vessels}
#'   \item{vessel_name}{Official name of the vessel}
#'   \item{species_name}{General name of the species that was caught}
#'   \item{live_catch_ton}{Fresh weight of the catch in tons}
#'   \item{catch_ton}{final weight of the catch in tons}
#'   ...
#' }
#' @source \url{https://datos.gob.mx/busca/organization/conapesca}

"landings"
