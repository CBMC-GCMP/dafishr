#' Label points when vessel is at port
#'
#' The function joins ports locations using data from ports buffers. `mx_ports` data is used which is
#' provided by INEGI https://en.www.inegi.org.mx/
#'
#' The function adds a `location` column indicating if the vessel was at port or at sea.
#'
#' @param x a data.frame with latitude and longitude coordinates
#' @param buffer_size a number (double) indicating the size of the buffer for the ports to implement
#' @param mx_ports is a shapefile of point data storing coordinates of ports and marina in Mexico, you can upload this using `data("mx_ports")`
#' @return A data.frame
#' @export
#' @importFrom dplyr %>%
#' @importFrom rlang .data
#'
#' @examples
#'
#' # With sample data
#'
#' data("sample_dataset")
#' data("mx_ports")
#' vms_cleaned <- vms_clean(sample_dataset)
#'
#' # It is a good idea to subsample when testing... it takes a while on the full data!
#'
#' vms_subset <- dplyr::sample_n(vms_cleaned, 1000)
#' with_ports <- join_ports_locations(vms_subset)
#' with_ports_sf <- sf::st_as_sf(with_ports, coords = c("longitude", "latitude"), crs = 4326)
#'
#' data("mx_shape")
#' library(ggplot2)
#' ggplot(mx_shape) +
#'   geom_sf(col = "gray90") +
#'   geom_sf(data = with_ports_sf, aes(col = location)) +
#'   facet_wrap(~location) +
#'   theme_bw()


join_ports_locations <-
  function(x, mx_ports, buffer_size = 0.15) {
    if (!"id" %in% colnames(x)) {
      cat("creating ids...")
      x <- x %>% dplyr::mutate(id = dplyr::row_number())
    } else {
      NULL
    }
    sf::sf_use_s2(FALSE)
    utils::data("mx_ports", envir = environment())

    mx_ports <- sf::st_transform(mx_ports, crs = 4326)
    buffer <- sf::st_buffer(mx_ports, buffer_size)
    buffer <- sf::st_make_valid(buffer)

    x_sf <- sf::st_as_sf(
      as.data.frame(x),
      coords = c("longitude", "latitude"),
      crs = 4326,
      remove = F
    )

    at_sea <- sf::st_difference(x_sf, sf::st_union(buffer))
    at_sea <- at_sea %>%
      dplyr::mutate(location = "at_sea") %>%
      dplyr::select(.data$id, .data$location)

    merge(x, at_sea, by = "id", all.x = T) %>%
      as.data.frame() %>%
      dplyr::mutate(location = tidyr::replace_na(.data$location, "port_visit")) %>%
      dplyr::select(-.data$geometry)
  }
