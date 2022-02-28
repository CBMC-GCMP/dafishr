#' Fixing dates and column names
#'
#' This function cleans raw VMS data column files, eliminate NULL values in coordinates, parse dates, and returns a data.frame
#'
#' It takes a raw data file downloaded using the `vms_download()` function by specifying directly its path
#' or by referencing a data.frame already stored as an R object. If path is used, column with the name of the
#' raw file is conveniently added as future reference. It also split date into three new colums `year`, `month`, `day`, and retains the original `date` column.
#' This function can be used with `apply` functions over a list
#' of files or it can be paralleled using `furrr` functions.
#'
#' @param path_to_data it can be a path to the file downloaded or the data object itself.
#' If function is used with a path it adds a `file` column to the returning data.frame object that
#' stores the name of the file as a reference.
#'
#' @return A data.frame
#' @export
#'
#' @examples
#'
#' # Using a path to a downloaded raw file
#' \dontrun{
#' vms_clean("VMS-data/VMS-data/RLMSEP_2019/1.- ENERO/01-10-ENE-2019.csv")
#' }
#'
#' # Using sample dataset, or a data.frame already stored as an object
#' data("sample_dataset")
#' cleaned_vms <- vms_clean(sample_dataset)
#' head(cleaned_vms)
utils::globalVariables(c("any_of", "latitude", "longitude", "direction", "speed"))

vms_clean <- function(path_to_data) {
  suppressWarnings(
    if (is.character(path_to_data) == TRUE) {
      x <- readr::read_csv(path_to_data,
        na = c("NA", "<NA>", "", " ", "?", "NULL"),
        col_types = vroom::cols(),
        locale = readr::locale(encoding = "latin1")
      )

      names(x) <- c(
        "vessel_name",
        "RNP",
        "port_base",
        "owner",
        "date",
        "latitude",
        "longitude",
        "speed",
        "direction"
      )

      res <- x %>%
        dplyr::mutate(date = as.POSIXct(date, format = "%d/%m/%Y %H:%M", tz = "UTC")) %>%
        dplyr::mutate(year = lubridate::year(date)) %>%
        dplyr::mutate(month = lubridate::month(date)) %>%
        dplyr::mutate(day = lubridate::day(date)) %>%
        tibble::rowid_to_column(., "id") %>%
        dplyr::relocate(any_of(c("id", "year", "month", "day", "date"))) %>%
        dplyr::filter(!is.na(latitude)) %>%
        dplyr::filter(!is.na(longitude)) %>%
        dplyr::mutate(direction = as.numeric(direction)) %>%
        dplyr::mutate(speed = as.numeric(speed)) %>%
        dplyr::mutate(file_name = stringr::str_remove(path_to_data, "data/VMS-data/raw//"))

      empty_coordinates <- x %>%
        dplyr::filter(is.na(latitude)) %>%
        dplyr::filter(is.na(longitude))
      cat(paste0("Cleaned: ", print(nrow(empty_coordinates)), " empty rows from data!"))
      res
    } else if (is.data.frame(path_to_data) == TRUE) {
      x <- path_to_data

      names(x) <- c(
        "vessel_name",
        "RNP",
        "port_base",
        "owner",
        "date",
        "latitude",
        "longitude",
        "speed",
        "direction"
      )

      res <- x %>%
        dplyr::mutate(date = as.POSIXct(date, format = "%d/%m/%Y %H:%M", tz = "UTC")) %>%
        dplyr::mutate(year = lubridate::year(date)) %>%
        dplyr::mutate(month = lubridate::month(date)) %>%
        dplyr::mutate(day = lubridate::day(date)) %>%
        tibble::rowid_to_column(., "id") %>%
        dplyr::relocate(any_of(c("id", "year", "month", "day", "date"))) %>%
        dplyr::mutate(
          latitude = as.numeric(latitude),
          longitude = as.numeric(longitude)
        ) %>%
        dplyr::filter(!is.na(latitude)) %>%
        dplyr::filter(!is.na(longitude)) %>%
        dplyr::mutate(direction = as.numeric(direction)) %>%
        dplyr::mutate(speed = as.numeric(speed))

      empty_coordinates <- x %>%
        dplyr::mutate(
          latitude = as.numeric(latitude),
          longitude = as.numeric(longitude)
        ) %>%
        dplyr::filter(is.na(latitude)) %>%
        dplyr::filter(is.na(longitude))
      cat(paste0("Cleaned: ", print(nrow(empty_coordinates)), " empty rows from data! \n"))
      res
    } else {
      cat("Data must be a path to folder or data.frame object")
    }
  )
}
