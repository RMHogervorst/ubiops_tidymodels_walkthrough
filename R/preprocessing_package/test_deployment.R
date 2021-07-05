## test deployment logic
input_data <- list(data="../diabetes.csv", training=TRUE)
source('deployment.R')
init() # loads packages
request(input_data)
# restart session
input_data <- list(data="../diabetes.csv", training=FALSE)
source('deployment.R')
init() # loads packages
request(input_data)
## seems alright.
## 

dir.create("deployment",showWarnings = FALSE)
file.copy(c("deployment.R", "renv.lock"), c("deployment/deployment.R", "deployment/renv.lock"))
zip("../preprocessing.zip", c("deployment/deployment.R", "deployment/renv.lock"))
