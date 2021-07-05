#' @title Init
#' @description Initialisation method for the deployment.
#'     It can for example be used for loading modules that have to be kept in memory or setting up connections.
#' @param base_directory (str) absolute path to the directory where the deployment.R file is located
#' @param context (named list) details of the deployment that might be useful in your code
init <- function(base_directory, context) {
  print("Initialising Deployment")
  library(readr)  ### this does add 6 packages, some of those also necessary for recipes
  library(recipes)
}

#' @title Request
#' @description Method for deployment requests, called separately for each individual request.
#' @param input_data (str or named list) request input data
#'     - In case of structured input: a named list, with as keys the input fields as defined upon deployment creation
#'     - In case of plain input: a string
#' @param base_directory (str) absolute path to the directory where the deployment.R file is located
#' @param context (named list) details of the deployment that might be useful in your code
#' @return output data (str or named list) request result
#'     - In case of structured output: a named list, with as keys the output fields as defined upon deployment creation
#'     - In case of plain output: a string
request <- function(input_data, base_directory, context) {
  print("Processing request for My Deployment")
  print("Loading data")
  diabetes_data <- read_csv(input_data[['data']])
  ### Create specification of what we want to achieve
  diabetes_recipe <- 
    ## predict outcome with all variables
    recipe(diabetes_data, Outcome~.) %>%  
    ## replace zeros in 'Glucose','BloodPressure','SkinThickness','Insulin','BMI' with NA
    step_mutate(
      Glucose = ifelse(Glucose ==0 , NA_real_, Glucose), # there is probalby a dplyr funciton that is faster/better
      BloodPressure = ifelse(BloodPressure ==0 , NA_real_, BloodPressure),
      SkinThickness = ifelse(SkinThickness ==0 , NA_real_, SkinThickness),
      Insulin = ifelse(Insulin ==0 , NA_real_, Insulin),
      BMI = ifelse(BMI ==0 , NA_real_, BMI)
    ) %>% 
    ## impute mean for Glucose and BloodPressure
    step_impute_mean(Glucose, BloodPressure) %>% 
    ## Impute median for SkinThickness, Insulin and BMI
    step_impute_median(SkinThickness, Insulin, BMI) %>% 
    ## scaling all columns except outcome (shorthand for manually specifying the columns)
    step_normalize(all_predictors()) %>% 
    ## compute the means and medians, and scaling values.
    prep()  
  print("Replacing nonsensical values with 0" )
  print("and imputing missing values")
  print("Scaling data")
  ## Actually executing the recipe.
  diabetes_preprocessed <- 
    diabetes_recipe %>% 
    bake(diabetes_data) 
  if(input_data[["training"]]){
    # split X and Y from each other
    Y <- diabetes_preprocessed %>% select(Outcome)
    X <- diabetes_preprocessed %>% select(-Outcome)
  }else{
    X <- diabetes_data
    Y <- tibble(1)
  }
  write_csv(X, file = 'x.csv')
  write_csv(Y, file = "y.csv", col_names = FALSE)
  ## and finally return the results
  list(
    "cleaned_data"= 'x.csv', 
    "target_data"= 'y.csv'
  )
}
