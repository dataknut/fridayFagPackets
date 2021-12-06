# loads the data and runs the Rmd render

# Packages ----
library(data.table)
library(here)

# Functions ----
source(here::here("R", "functions.R"))

makeReport <- function(f){
  # default = html
  rmarkdown::render(input = paste0(here::here("itsTheCatsStupid", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".html")
  )
}

# Set data path ----
dp <- "~/Dropbox/data/"

# Run report ----

#> define yaml ----
rmdFile <- "itsTheCatsStupid" # not the full path
title = "#backOfaFagPacket: Its the Cats, stupid"
subtitle = "Does cat ownership correlate with home energy demand?"
authors = "Ben Anderson"

#> load the postcode data here (slow)

postcodes_elec_dt <- data.table::fread(paste0(dp, "beis/subnationalElec/Postcode_level_all_meters_electricity_2015.csv"))
postcodes_elec_dt[, pcd_district := data.table::tstrsplit(POSTCODE, " ", keep = c(1))]
pc_district_elec_dt <- postcodes_elec_dt[, .(elec_nPostcodes = .N, 
                                           total_elec_kWh = sum(`Consumption (kWh)`, na.rm = TRUE),
                                           nElecMeters = sum(`Number of meters`, na.rm = TRUE)
                                           ), keyby = .(pcd_district)]
nrow(pc_district_elec_dt)

postcodes_gas_dt <- data.table::fread(paste0(dp, "beis/subnationalGas/Experimental_Gas_Postcode_Statistics_2015.csv"))
postcodes_gas_dt[, pcd_district := data.table::tstrsplit(POSTCODE, " ", keep = c(1))]
pc_district_gas_dt <- postcodes_gas_dt[, .(gas_nPostcodes = .N,
                                           total_gas_kWh = sum(`Consumption (kWh)`, na.rm = TRUE),
                                           nGasMeters = sum(`Number of meters`, na.rm = TRUE)), keyby = .(pcd_district)]
nrow(pc_district_gas_dt)

setkey(pc_district_elec_dt, pcd_district)
setkey(pc_district_gas_dt, pcd_district)

pc_district_energy_dt <- pc_district_gas_dt[pc_district_elec_dt]

# load one we prepared earlier using https://git.soton.ac.uk/SERG/mapping-with-r/-/blob/master/R/postcodeWrangling.R
pc_district_region_dt <- data.table::fread(paste0(dp, "UK_postcodes/postcode_districts_2016.csv"))
setkey(pc_district_region_dt, pcd_district)
nrow(pc_district_region_dt)

pc_district_region_dt[, .(n = .N), keyby = .(GOR10CD, GOR10NM)]
nrow(pc_district_energy_dt)
pc_district_energy_dt <- pc_district_energy_dt[pc_district_region_dt]
nrow(pc_district_energy_dt)

#> re-run report here ----
makeReport(rmdFile)
