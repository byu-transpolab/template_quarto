#' Make the example analysis data
#' 
make_data <- function(){
  mtcars |>
    as_tibble(rownames = "vehicle") |>
    mutate(
      transmission = factor(am, labels = c("Automatic", "Manual")),
      cylinders = factor(cyl)
    ) |>
    select(
      vehicle,
      mpg,
      weight = wt,
      horsepower = hp,
      displacement = disp,
      transmission,
      cylinders
    )
}


#' Estimate models
#' 
#' @param analysis_data The data frame returned by make_data
#' 
estimate_models <- function(analysis_data){
  
  # first model: fuel economy explained by vehicle weight and horsepower
  model1 <- lm(mpg ~ weight + horsepower, data = analysis_data)
  
  # second model: add transmission type
  model2 <- update(model1, . ~ . + transmission)
  
  # put models in a list and return
  models <- list("Model 1" = model1, "Model 2" = model2)
  models
  
}

