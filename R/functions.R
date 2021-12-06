# useful functions
# use source(here::here("R", "functions.R")) to load

require(flextable) # use require so it fails if not present & can't install

makeFlexTable <- function(df, cap = "caption"){
  # makes a pretty flextable - see https://cran.r-project.org/web/packages/flextable/index.html
  ft <- flextable::flextable(df)
  ft <- flextable::colformat_double(ft, digits = 1)
  ft <- flextable::fontsize(ft, size = 9)
  ft <- flextable::fontsize(ft, size = 10, part = "header")
  ft <- flextable::set_caption(ft, caption = cap)
  return(flextable::autofit(ft))
}