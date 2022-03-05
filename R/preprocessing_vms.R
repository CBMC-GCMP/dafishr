#' Preprocessing VMS data
#'
#' This functions bundles all the cleaning functions and allows them to be
#' easily used in parallel processing to speed up the cleaning of all the VMS data `.csv` files.
#' While it runs, it creates an folder called `preprocessed` that will store VMS data that
#' underwent the preprocessing. If multiple files are used as input (see examples below) it will create
#' multiple files. All the outputs are in `.fst` format, which allows fast upload of large files.
#' See `fst` package documentation for further information https://www.fstpackage.org/.
#'
#'
#'
#' @param path it can be a path to the file downloaded or the data object itself.
#' If function is used with a path it adds a `file` column to the returning data.frame object that
#' stores the name of the file as a reference.
#'
#'
#' @return A `.fst` file saved within a `preprocessed` directory automatically created that stores
#' each of the files that are used as input to the function.
#' @export
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
#' vms_download(2019) # downloads raw data from 2019 with standard subfolders
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
preprocessing_vms <- function(path) {
  vms <- vms_clean(path)

  # Intersect with landmass to filter nonsensical coordinates

  vms <- clean_land_points(vms, mx_inland)

  # Intersect with ports buffer and create a column "port_visit" at port or at sea
  vms <- join_ports_locations(vms, mx_ports)

  # Intersect with MX MPAs and create a column with MPA name or OA
  vms <- join_mpa_data(vms, all_mpas)


  dir.create("preprocessed/")

  fst::write_fst(vms, paste0("vms_", unique(vms$year), "_", unique(vms$year), "_preprocessed.fst"))
  cat(paste0("Writing file: vms_", unique(vms$year), "_", unique(vms$year), "_preprocessed.fst"))
}
