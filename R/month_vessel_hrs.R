#' Fishing activity in hours each month of all the target vessels
#'
#' A `data.frame` object containing modeled fishing activity per each zone (EEZ and MPAs) in terms of hrs from 2008 to 2021.
#'
#' @format A `data.frame`  with 259,310 rows and 5 columns
#' \describe{
#'   \item{year}{year of the activity}
#'   \item{month}{month of the activity}
#'   \item{vessel_name}{Official name of the vessel}
#'   \item{zome}{Area where the fishing activity was detected}
#'   \item{hrs}{Total hours}
#'   ...
#' }
#' @source MX Datos Abiertos intiative

"month_vessel_hrs"
