#' Preprocessing Vessel Monitoring System data
#'
#' This functions bundles all the cleaning functions and allows them to be
#' easily used in parallel processing to speed up the cleaning of all the Vessel Monitoring System, VMS, data `.csv` files.
#' While it runs, it creates a folder called `preprocessed` that will store VMS data that
#' underwent the preprocessing. If multiple files are used as input (see examples below) it will create
#' multiple files. All the outputs are in `.fst` format, which allows fast upload of large files.
#' See `fst` package documentation for further information https://www.fstpackage.org/.
#'
#'
#'
#' @param files.path it can be a path to the file downloaded or the data object itself.
#' If function is used with a path it adds a `file` column to the returning data.frame object that
#' stores the name of the file as a reference.
#' @param destination.folder it must record the path to a folder were all the preprocessed files
#' will be stored.
#'
#'
#' @return A `.fst` file saved within a `preprocessed` directory automatically created that stores
#' each of the files that are used as input to the function.
#' @export
#' @import ggplot2
#' @import readxl
#' @import tibble
#'
#' @examples
#'
#' # An example with the `sample.dataset`
#' \dontrun{
#' preprocessing_vms(sample_dataset)
#' }
#'
#' # An example on downloaded data
#' \dontrun{
#' vms_download(year = 2019, destination.folder = getwd()) # downloads raw data from 2019 with standard subfolders
#'
#' preprocessing_vms("VMS-data/RLMSEP_2019/1.-ENERO/01-31 ENE 2008.csv")
#' }
#'
#' # An example running everything in parallel on multiple files
#' \dontrun{
#'
#' library(future.apply) # this library is need for parallel processing
#' library(fst) # this allows to load fst type of files
#'
#' # Creating a list of file names from downloaded data (change the path if needed)
#' file_names <- list.files("VMS-data/", pattern = ".csv", full.names = T, recursive = T)
#'
#'
#' # this plans a parallel session, set workers carefully according to your CPU capabilities
#' plan(multisession, workers = 2)
#'
#' # This runs the function in parallel
#' system.time(
#'   future_lapply(file_names, preprocessing_vms)
#' )
#' }
preprocessing_vms <- function(files.path, destination.folder) {
            if (missing(destination.folder)) {
                        stop(
                                    "destination.folder argument must be specified with an existing path"
                        )
            }

            mx_inland <- dafishr::mx_inland
            mx_ports <- dafishr::mx_ports
            all_mpas <- dafishr::all_mpas
            suppressMessages({
            suppressWarnings({
            vms <- vms_clean(files.path)

            # Intersect with landmass to filter nonsensical coordinates

            vms <- clean_land_points(vms, mx_inland)

            # Intersect with ports buffer and create a column "port_visit" at port or at sea
            vms <- join_ports_locations(vms, mx_ports)

            # Intersect with MX MPAs and create a column with MPA name or OA
            vms <- join_mpa_data(vms, all_mpas)


            dir.create(destination.folder)
            })
            })
            fst::write_fst(
                        vms,
                        paste0(
                                    destination.folder,
                                    "/vms_",
                                    unique(vms$year),
                                    "_",
                                    unique(vms$month),
                                    "_",
                                    min(vms$day),
                                    "_",
                                    max(vms$day),
                                    "_preprocessed.fst"
                        )
            )
            message(
                        paste0(
                                    "Writing file: vms_",
                                    unique(vms$year),
                                    "_",
                                    unique(vms$month),
                                    "_",
                                    min(vms$day),
                                    "_",
                                    max(vms$day),
                                    "_preprocessed.fst in the ",
                                    destination.folder,
                                    " folder"
                        )
            )
}
