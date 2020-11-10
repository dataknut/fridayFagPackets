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
rmdFile <- "retrofitOrBust" # not the full path
title = "#backOfaFagPacket: Retrofit or bust?"
subtitle = ""
authors = "Ben Anderson"

makeReport(rmdFile)