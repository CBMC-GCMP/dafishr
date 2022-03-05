#'  Clean points falling inland
#'
#' This functions eliminates points falling inland by using `st_difference()` function from the `sf` package.
#'
#'
#' Points falling inland in VMS dataset are obvious mistakes, thus need to be eliminated from the data.
#' The function calls a stored shapefile `mx_inland` which is a custom `sf` object created using a coastline buffer to avoid eliminating points because of lack of precision within the shapefiles.
#' The function works with any dataset containing coordinate points in `crs = 4326` and named `latitude` and `longitude`. See first example with a
#' non-VMS dataset.
#' A second example below showes the usage on VMS sample data.
#'
#' @section Warning:
#' This function takes a while!! To test you can use the `dplyr::sample_n()` function as it is shown in the example.
#'
#' @param x A data.frame containing latitude and longitude coordinates of vessels tracks to be cleaned by land area
#' @param mx_inland is a shapefile loaded with the packages representing inland Mexico area, it can be uploaded with `data("mx_inland)`
#' @return A data.frame object
#'
#' @export
#' @importFrom dplyr %>%
#' @importFrom rlang .data
#' @examples
#'
#' # with non VMS data
#' x <- data.frame(
#'   longitude = runif(1000, min = -150, max = -80),
#'   latitude = runif(1000, min = 15, max = 35)
#' )
#' data("mx_inland")
#' x <- clean_land_points(x, mx_inland)
#'
#' # using sample_dataset
#'
#' data("sample_dataset", "mx_inland")
#'
#' vms_cleaned <- vms_clean(sample_dataset)
#' vms_no_land <- clean_land_points(vms_cleaned, mx_inland)
#'
#' # You can check the results by plotting the data
#'
#' vms_cleaned_sf <- sf::st_as_sf(vms_cleaned, coords = c("longitude", "latitude"), crs = 4326)
#'
#' vms_no_land_sf <- sf::st_as_sf(vms_no_land, coords = c("longitude", "latitude"), crs = 4326)
#'
#' library(ggplot2)
#' ggplot(vms_cleaned_sf) +
#'   geom_sf(col = "red") +
#'   geom_sf(data = vms_no_land_sf, col = "black")
#'
#' # in the provided example only few inland points are eliminated.
#' # There are more evident one within historical data.
clean_land_points <- function(x, mx_inland = mx_inland) {
  sf::sf_use_s2(FALSE)

  land_area <- sf::st_make_valid(sf::st_transform(mx_inland, crs = 4326))

  x <- sf::st_as_sf(as.data.frame(x), coords = c("longitude", "latitude"), crs = 4326, remove = F)
  x <- sf::st_difference(x, sf::st_union(land_area))
  x <- x %>%
    as.data.frame() %>%
    dplyr::select(-.data$geometry)
  x
}
