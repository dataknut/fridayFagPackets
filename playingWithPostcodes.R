postcodes <- data.table::fread("~/Dropbox/data/UK_postcodes/NSPL_AUG_2020_UK/Data/NSPL_AUG_2020_UK.csv.gz")

postcodes[, pcd_sector := data.table::tstrsplit(pcds, " ", keep = c(1))]
pc_sectors_dt <- postcodes[, .(nPostcodes = .N), keyby = .(pcd_sector, rgn)]
pc_sectors_dt[, GOR10CD := rgn]


region_codes <- readxl::read_xlsx("~/Dropbox/data/UK_postcodes/NSPL_AUG_2020_UK/Documents/Region names and codes EN as at 12_10 (GOR).xlsx")
region_code_dt <- data.table::as.data.table(region_codes)

setkey(region_code_dt, GOR10CD)
setkey(pc_sectors_dt, GOR10CD)

dt <- region_code_dt[pc_sectors_dt]

data.table::fwrite(dt, file = here::here("data", "postcode_sectors_dt.csv"))
