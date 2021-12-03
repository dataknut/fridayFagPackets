makeReport <- function(f){
  # default = html
  rmarkdown::render(input = paste0(here::here("retrofitOrBust", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".html")
  )
}

# >> run report ----
rmdFile <- "itsTheCatsStupid" # not the full path
title = "#backOfaFagPacket: It's the Cats, stupid"
subtitle = "Does cat ownership correlate with home energy demand?"
authors = "Ben Anderson"

makeReport(rmdFile)