source("deployment.R")
input_data <- list(data="../dummy_data_for_predicting.csv")
init()
request(input_data = input_data)


# make deployment
file.remove("../predictor_package.zip")
dir.create("deployment",showWarnings = FALSE)
file.copy(c("deployment.R", "renv.lock", "knnmodel.RDS"), c("deployment/deployment.R", "deployment/renv.lock", "deployment/knnmodel.RDS"),overwrite = TRUE)
zip("../predictor_package.zip", c("deployment/deployment.R", "deployment/renv.lock", "deployment/knnmodel.RDS"))
