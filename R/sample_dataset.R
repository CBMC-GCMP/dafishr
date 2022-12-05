#' Vessel Monitoring System, VMS, sample dataset from Mexican fishery commission
#'
#' A `data.frame` object extracted from a raw dataset of Vessels Monitoring System, VMS, data from the year 2019.
#'
#' @format A `data.frame` with 10,000 rows and 9 columns.
#' \describe{
#'   \item{Nombre}{Name of the vessel}
#'   \item{RNP}{Unique code identifing the vessel}
#'   \item{Puerto Base}{Base port where the vessel is officially registered}
#'   \item{Permisionario o Concesionario}{Owner of the vessel or partnership name}
#'   \item{FechaRecepcionUnitrac}{Date as "%d/%m/%Y %H:%M"}
#'   \item{Latitud}{Latitude degree in WGS84, crs = 4326, of the position of the vessel}
#'   \item{Longitud}{Longitude degree in WGS84, crs = 4326, of the position of the vessel}
#'   \item{Velocidad}{Speed in knots of the vessel at that specific time}
#'   \item{Rumbo}{Direction in degrees of the vessel at that specific time}
#'   ...
#' }
#' @source \url{https://www.datos.gob.mx/}

"sample_dataset"
