#' Download VMS raw data
#'
#' This functions download data form the datos abiertos inititative.
#'
#'
#' Data are downloaded from this link: https://www.datos.gob.mx/busca/dataset/localizacion-y-monitoreo-satelital-de-embarcaciones-pesqueras/resource/309e872a-dbca-4962-b14f-f0da833abebe
#' Downloaded data are stored automatically in a `VMS-data` folder. Within the main folder, data is organized in
#' different folders by months (in spanish names) and within each there are multiple `.csv` files
#' each containing two weeks of data points.
#'
#' @param year year of data that user wants to download are selected default to the last year. A vector of years can also be used.
#'
#' @return saves downloaded data into a folder called `VMS-data` within the working directory
#' @export
#'
#' @examples
#'
#' # Download single year
#' \dontrun{
#' vms_download(2019)
#' }
#'
#' # Download multiple years
#' \dontrun{
#' vms_download(2015:2021)
#' }
#'
vms_download <- function(year = lubridate::year((Sys.time())) - 1) {
  url <- paste0("https://nube.conapesca.gob.mx/datosabiertos/RLMSEP_", year, ".zip")

  utils::download.file(url, destfile = "download_VMS.zip")
  utils::unzip("download_VMS.zip", exdir = "VMS-data")
  unlink("download_VMS.zip")
}
