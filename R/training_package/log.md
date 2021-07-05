* created project
* create deployment.R
* add skeleton init and request
* renv::activate()  # runs the init too.
* when extracting data from lists, make sure to use `[[]]` `input_data[["cleaned_data"]]` so you get the underlying data, not the named thing.
* binding together X and y, to make split object
* split data with seed 42 (of course different results, but consistent)
* set up knn model 
* check what [classification report in scikitlearn](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.classification_report.html) is: Text summary of the precision, recall, F1 score for each class. 
* hadd to add kknn package manually? renv::record("kknn")
* created test_script seems to work out alright.
* create deployment.zip
* manually create deployment through website with input(cleaned_data, target_data) and output(trained_model, model_score)
* is building, so it seems to be alright
* testing out with x and y from other deployment.
* exception, because kknn is not installed.
* added it to the library calls, updated renv.lock
* finally works! (seems to be an error in tidymodels that requires you to load the package again?)
 