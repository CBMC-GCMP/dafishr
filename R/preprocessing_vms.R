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
#' @return A `.fst` file saved within a directory chosen by the user, that is created automatically if does not exist, and that stores
#' each of the files that are used as input to the function.
#' @export
#' @import ggplot2
#' @import readxl
#' @import tibble
#'
#' @examples
#'
#' # An example with the `sample.dataset`
#' \donttest{
#' preprocessing_vms(sample_dataset, destination.folder = tempdir())
#' }
#'
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
