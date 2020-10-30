makeReport <- function(f){
  # default = html
  rmarkdown::render(input = paste0(here::here("2020-10-16-retrofOrBust", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".html"),
                    output_format = "html_document"
  )
  # word
  rmarkdown::render(input = paste0(here::here("2020-10-16-retrofOrBust", f), ".Rmd"),
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(here::here("docs/"), f, ".docx"),
                    output_format = "word_document"
  )
}

# >> run report ----
rmdFile <- "retrofitOrBust" # not the full path
title = "Retrofit or bust?"
subtitle = ""
authors = "Ben Anderson"

makeReport(rmdFile)