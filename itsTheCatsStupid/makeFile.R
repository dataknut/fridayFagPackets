makeReport <- function(f){
  # default = html
  rmarkdown::render(input = paste0(here::here("itsTheCatsStupid", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".html")
  )
}

# Run report ----

#> set data path ----
dp <- "~/Dropbox/data/"

#> define yaml ----
rmdFile <- "itsTheCatsStupid" # not the full path
title = "#backOfaFagPacket: Its the Cats, stupid"
subtitle = "Does cat ownership correlate with home energy demand?"
authors = "Ben Anderson"

#> load the postcode data here (slow)
postcodes_dt <- data.table::fread(paste0(dp, "UK_postcodes/PCD_OA_LSOA_MSOA_LAD_AUG20_UK_LU.csv.gz"))
postcodes_dt[, pcd_sector := tstrsplit(pcds, " ", keep = c(1))]
lsoa_DT <- postcodes_dt[, .(nPostcodes = .N), keyby = .(lsoa11cd, pcd_sector, ladnm, ladnmw)]

#> re-run report here
makeReport(rmdFile)