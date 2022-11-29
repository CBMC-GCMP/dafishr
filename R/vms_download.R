#' Download Vessel Monitoring System, VMS, raw data
#'
#' This functions download data form the *Datos Abiertos* initiative
#'
#'
#' Data are downloaded from this link: https://www.datos.gob.mx/busca/dataset/localizacion-y-monitoreo-satelital-de-embarcaciones-pesqueras/
#' Downloaded data will be downloaded and decompressed in a `VMS-data` folder in
#' a location chosen by the user by specifying a path in `destination.folder`.
#' If a location is not specified it downloads data by default to the current working directory.
#' Within the main folder, data is organized in different folders by months (in Spanish names)
#' and within each there are multiple `.csv` files each containing two weeks of data points.
#'
#' @param year year of data that user wants to download are selected default to the last year. A vector of years can also be used.
#' @param destination.folder can be set to a folder where user want the data to be downloaded into. Defaults to working directory.
#' @param check.url.certificate logical. Under Ubuntu systems the function might draw a certificate error, you can deactivate the certificate check by setting this to `FALSE` and should work.
#'
#' @return saves downloaded data into a folder called `VMS-data` within the directory specified
#' @export
#' @import stringr
#'
#' @examples
#'
#' # Download single year
#' # in Ubuntu it draws a certificate error when downloading, testing in windows and MacOS
#' # does not draw that error and you can use default certificate checking.
#'\donttest{
#' vms_download(2019, destination.folder = tempdir(), check.url.certificate = FALSE)
#'}
#'
#'
vms_download <- function(year = lubridate::year((Sys.time())) - 1,
                         destination.folder,
                         check.url.certificate = TRUE) {
            if(missing(destination.folder)) {
                        stop("destination.folder argument must be specified with an existing path")
            }

            url <- paste0("https://nube.conapesca.gob.mx/datosabiertos/RLMSEP_", year, ".zip")

            if(check.url.certificate == TRUE) {

                        utils::download.file(url, destfile = stringr::str_replace_all(paste0(destination.folder, "/download_temp.zip"), "//", "/"))
                        utils::unzip(stringr::str_replace_all(paste0(destination.folder, "/download_temp.zip"), "//", "/"), exdir = stringr::str_replace_all(paste0(destination.folder, "/VMS-data"), "//", "/"))
                        unlink(paste0(destination.folder, "/download_temp.zip"))

            } else {
                        options(download.file.method="wget",
                                download.file.extra="--no-check-certificate")

                        utils::download.file(url, destfile = stringr::str_replace_all(paste0(destination.folder, "/download_temp.zip"), "//", "/"))
                        utils::unzip(stringr::str_replace_all(paste0(destination.folder, "/download_temp.zip"), "//", "/"), exdir = stringr::str_replace_all(paste0(destination.folder, "/VMS-data"), "//", "/"))
                        unlink(paste0(destination.folder, "/download_temp.zip"))
            }


}
