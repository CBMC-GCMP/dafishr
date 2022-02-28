
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dafishr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

<!-- badges: end -->

The goal of dafishr is to provide an easy way to download VMS and
analyse data from the Sismep of the Mexican Fishery Commission available
at [Datos
Abiertos](https://www.datos.gob.mx/busca/dataset/localizacion-y-monitoreo-satelital-de-embarcaciones-pesqueras/resource/309e872a-dbca-4962-b14f-f0da833abebe)
initiative. Within the package you can find tools that allows you to
download VMS data, wrangle and clean raw data, and analyse tracks.

You can follow the instruction below using a sample dataset that comes
along with the package, or you can use the function on data you can
download yourself by using the `vms_download()` function. See ?vms_data
for details on its usage.

## Installation

You can install the development version of dafishr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("CBMC-GCMP/dafishr")
```

## Downloading raw data on your computer

VMS data comes organized by year. The function `vms_download()`
automatically downloads it and store into the working directory in a
`VMS-data` folder. Within the folder raw data are organized by monthly
folders (with names in Spanish) that contain several `.csv` files that
usually store byweekly data intervals. Each file have different rows and
some have different column names. For that we highly recommend to use
the `vms_clean()` function. The latter corrects several inconsistencies
within the raw data. If you have any suggestion or spot some errors we
will be very pleased if you create an issue.

The function below downloads data from the year 2019.

``` r
library(dafishr)

vms_download(2019)
```

## Using the cleaning functions

The first `vms_clean()` function works on the VMS `data.frame`. You can
either load downloaded data or use the `sample_dataset` that you can
call and clean like so:

``` r
library(dafishr)
data("sample_dataset")
vms_cleaned <- vms_clean(sample_dataset)
#> [1] 969
#> Cleaned: 969 empty rows from data!
```

The `vms_clean()` function returns a message with the number of rows
that were cleaned because they contained NULL values in coordinates.

You can find a complete tutorial at: