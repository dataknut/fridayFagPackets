makeReport <- function(f){
  # default = html
  rmarkdown::render(input = paste0(here::here("2020_30_10_EPCs", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".html")
  )
  # word
  rmarkdown::render(input = paste0(here::here("2020_30_10_EPCs", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".docx"),
                    output_format = "word_document"
  )
}

# >> run report ----
rmdFile <- "carbonCosts" # not the full path
title = "What can EPC data tell us about the domestic cost of carbon?"
subtitle = ""
authors = "Ben Anderson"

makeReport(rmdFile)