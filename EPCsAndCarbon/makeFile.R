makeReport <- function(f){
  # default = html
  rmarkdown::render(input = paste0(here::here("EPCsAndCarbon", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".html")
  )
  # word
  rmarkdown::render(input = paste0(here::here("EPCsAndCarbon", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".docx"),
                    output_format = "word_document"
  )
}

# >> run report ----
rmdFile <- "epcChecks" # not the full path
title = "Checking EPC datasets for Southampton"
subtitle = "Data cleaning, outlier checks and coverage analysis"
authors = "Ben Anderson"

makeReport(rmdFile)