# loads the data and runs the Rmd render

# Packages ----
library(data.table)
library(here)

# Functions ----
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
postcodes_elec_dt[, pcd_sector := data.table::tstrsplit(POSTCODE, " ", keep = c(1))]
pc_sector_elec_dt <- postcodes_elec_dt[, .(nPostcodes = .N, 
                                           total_elec_kWh = sum(`Consumption (kWh)`),
                                           nElecMeters = sum(`Number of meters`)
                                           ), keyby = .(pcd_sector)]
nrow(pc_sector_elec_dt)

postcodes_gas_dt <- data.table::fread(paste0(dp, "beis/subnationalGas/Experimental_Gas_Postcode_Statistics_2015.csv"))
postcodes_gas_dt[, pcd_sector := data.table::tstrsplit(POSTCODE, " ", keep = c(1))]
pc_sector_gas_dt <- postcodes_gas_dt[, .(total_gas_kWh = sum(`Consumption (kWh)`),
                                           nGasMeters = sum(`Number of meters`)), keyby = .(pcd_sector)]
nrow(pc_sector_gas_dt)

setkey(pc_sector_elec_dt, pcd_sector)
setkey(pc_sector_gas_dt, pcd_sector)

pc_sector_energy_dt <- pc_sector_gas_dt[pc_sector_elec_dt]

pc_sector_region_dt <- data.table::fread(here::here("data", "postcode_sectors_dt.csv"))
setkey(pc_sector_region_dt, pcd_sector)

pc_sector_energy_dt <- pc_sector_region_dt[pc_sector_energy_dt]

#> re-run report here ----
makeReport(rmdFile)