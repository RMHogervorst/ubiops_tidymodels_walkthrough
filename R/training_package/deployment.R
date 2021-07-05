init <- function(base_directory, context){
  library(readr)
  library(magrittr)
  library(rsample)
  library(parsnip)  # model specifications. 
  library(yardstick)
}
request <- function(input_data, base_directory, context){
  print("Processing request for My Deployment")
  # Load the dataset
  print("Loading data")
  X <- read_csv(input_data[["cleaned_data"]])
  y <- read_csv(input_data[["target_data"]],col_names = "Outcome")
  ## The fact we have an X and y is just an scikitlearn artefact: the splittraintest function outputs
  ## 4 parts, and takes in 2. rsample takes a dataset and returns a split object.
  input_dataset <- X %>% 
    dplyr::bind_cols(y)
  input_dataset$Outcome <- as.factor(input_dataset$Outcome)
  set.seed(42)
  split_object <- initial_split(input_dataset, prop = 0.6,strata = Outcome)
  # set up model
  modelspec <- 
    nearest_neighbor(mode = "classification",neighbors = 7) %>% 
    set_engine("kknn")
  # fit the model
  trained_model <- modelspec %>% fit(Outcome~., data=training(split_object))
  # get accuracy on testset.
  test_results <- 
    testing(split_object) %>% 
    dplyr::bind_cols(
      trained_model %>% predict(testing(split_object))
      )
  # get accuracy
  acc <- test_results %>% accuracy(truth=Outcome, estimate = .pred_class) %>% dplyr::pull(.estimate)
  print(glue::glue("KNN accuracy: {round(acc, 4)}"))
  # create  classification report equivalent to scikitlearn. 
  classification_report <- metric_set(precision, recall, f_meas)
  class_results <- 
    test_results %>% 
    classification_report(truth=Outcome, estimate = .pred_class)
  print(glue::glue_data(class_results,"{.metric}: {round(.estimate,4)}"))
  # dump the model we have
  modelname <- 'knnmodel.RDS'
  write_rds(trained_model, modelname)
  list(trained_model = modelname, model_score=acc)  
}
