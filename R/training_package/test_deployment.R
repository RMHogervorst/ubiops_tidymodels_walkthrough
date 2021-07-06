input_data <- list(
  cleaned_data = "../preprocessing_package/x.csv", # make sure you ran preprocessing with training = TRUE
  target_data="../preprocessing_package/y.csv")
source("deployment.R")
init()
request(input_data)

file.remove("../training_package.zip")
dir.create("deployment",showWarnings = FALSE)
file.copy(c("deployment.R", "renv.lock"), c("deployment/deployment.R", "deployment/renv.lock"),overwrite = TRUE)
zip("../training_package.zip", c("deployment/deployment.R", "deployment/renv.lock"))
