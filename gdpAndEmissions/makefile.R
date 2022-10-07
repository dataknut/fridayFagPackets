# run quarto render

library(quarto)

quarto_render(input = here::here("gdpAndEmissions","GDP_emissions_trends.qmd")
              )

# should not need this - render should be able to do it?
  
file.copy(from = here::here("gdpAndEmissions","GDP_emissions_trends.html"), 
                     to = here::here("docs","GDP_emissions_trends.html"),overwrite = TRUE
          )