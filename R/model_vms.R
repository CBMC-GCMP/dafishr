#' Vessel Modeling with Gaussian Mixture Models
#'
#' This function uses `normalmixEM` from the `mixtools` package to model speed of vessels and estimates their behavior.
#' Specifically, if the vessel was in a fishing activity or cruising
#'
#' @param df a data.frame preprocessed using the `preprocessing_vms()` function from this package
#'
#' @return a data.frame with a `vessel_state` column with the type of model implemented
#' @export
#'
#' @examples
#' \donttest{
#' preprocessing_vms(sample_dataset, destination.folder = tempdir())
#' df <- fst::read_fst(paste0(tempdir(), "/vms_2019_1_1_10_preprocessed.fst"))
#' model_vms(df)
#' }
model_vms <- function(df) {
  at_sea <- df |>
    dplyr::filter(.data$location == "at_sea")  |>
    dplyr::select(.data$id, .data$speed)

  out <- return(tryCatch(
    {
      EM_all <- mixtools::normalmixEM(at_sea$speed,
        mu = c(1, 4, 8),
        sigma = c(1, 1, 1)
      )

      speed_threshold_EM <- EM_all$mu[1] + 1.96 * EM_all$sigma[1]
      at_sea$behaviour <- ifelse(at_sea$speed < speed_threshold_EM,
        "hauling", "not_hauling"
      )
      at_sea <- dplyr::select(at_sea, -.data$speed)
      res <- merge(df, at_sea, by = "id", all.x = T)  |>
        dplyr::mutate(vessel_state = ifelse(.data$location == "port_visit", "port_visit", .data$behaviour))  |>
        dplyr::mutate(vessel_state = ifelse(.data$vessel_state == "port_visit" & .data$speed > 0, "not_hauling", .data$vessel_state)) |>
        dplyr::mutate(model_type = "three_states")  |>
        dplyr::select(-.data$behaviour)

      return(res)
    },
    error = function(test) {
      message(paste("Test two state basic parameter for:", unique(df$vessel_name), "\n"))

      EM_all <- mixtools::normalmixEM(at_sea$speed,
        mu = c(1, 4),
        sigma = c(1, 1, 1)
      )

      speed_threshold_EM <- EM_all$mu[1] + 1.96 * EM_all$sigma[1]
      at_sea$behaviour <- ifelse(at_sea$speed < speed_threshold_EM,
        "hauling", "not_hauling"
      )
      at_sea <- dplyr::select(at_sea, -.data$speed)
      test <- merge(df, at_sea, by = "id", all.x = T) |>
        dplyr::mutate(vessel_state = ifelse(.data$location == "port_visit", "port_visit", .data$behaviour))  |>
        dplyr::mutate(vessel_state = ifelse(.data$vessel_state == "port_visit" & .data$speed > 0, "not_hauling", .data$vessel_state))  |>
        dplyr::mutate(model_type = "two_states") |>
        dplyr::select(-.data$behaviour)
      return(test)
    },
    error = function(cond) {
      message(paste("Can't model vessel:", unique(df$vessel_name), "\n"))
      x <- df  |>
        dplyr::mutate(behaviour = "not_modelled", vessel_state = "not_modelled", model_type = "not_modelled")  |>
        dplyr::mutate(vessel_state = ifelse(.data$vessel_state != "port_visit" & .data$speed < 5, "hauling", "not_hauling"))
      # Choose a return value in case of error
      return(x)
    }
  ))
  return(out)
}
