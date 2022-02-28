#' Buffer around remote Marine Protected Areas of Mexico
#'
#' A `sf` object containing shapefiles of buffers around remote MPAs in Mexico.
#' The buffer equals the area inside each MPA polygon and was created to assess differences in fishing
#' activity inside or outside each of the remote MPAs.
#'
#' @format A simple feature collection with 5 features and 2 fields
#' \describe{
#'   \item{Name}{Name of the MPAs to which the buffer correspond}
#'   \item{Description}{empty}
#'   \item{geometry}{column containing geometry details}
#'   ...
#' }
#' @source this project

"mpas_buffers"
