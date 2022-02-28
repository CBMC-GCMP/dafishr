#' Marine Protected Areas (MPAs) of Mexico
#'
#' A `sf` object containing shapefiles of MPA polygons in Mexico
#'
#' @format A simple feature collection with 24 features and 5 fields
#' \describe{
#'   \item{NOMBRE}{Name of the MPA in Spanish}
#'   \item{CAT_DECRET}{Decree category, which define the type of MPA}
#'   \item{ESTADOS}{State that have jurisdiction on the MPA}
#'   \item{MUNICIPIOS}{Municipality that have jurisdiction on the MPA}
#'   \item{REGION}{General regional localization of the MPA (in Spanish)}
#'   \item{geometry}{column containing geometry details}
#'   ...
#' }
#' @source \url{http://sig.conanp.gob.mx/website/pagsig/info_shape.htm}

"all_mpas"
