# 
init <- function(base_directory, context){
  library(readr)
  library(kknn)
  library(dplyr)
  library(parsnip)  # model specifications. 
  model <<- read_rds("knnmodel.RDS")
}
request <- function(input_data, base_directory, context){
  print('Loading data')
  input_data = read_csv(input_data[['data']])
  
  print("Prediction being made")
  predictions <- 
    model %>% 
    predict(input_data)
  diabetes_instances = sum(predictions$.pred_class == 1)
  print('Writing prediction to csv')
  predictions %>% 
    mutate(index=row_number()) %>% 
    select(index, diabetes_prediction = .pred_class) %>% 
    write_csv(file="prediction.csv")
  list(prediction="prediction.csv",predicted_diabetes_instances=diabetes_instances)
}