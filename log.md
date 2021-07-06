## from scikitlearn to tidymodels and renv
In this project I'm turning the scikitlearn tutorial/cookbook into a an 
R model. 

I'm going to use the same steps as the python scikit learn tutorial and
replace it with tidymodels. 

Running equivalent scikitlearn
https://ubiops.com/docs/ubiops_cookbook/scikit-deployment/index.html 


```
In this example we will show you the following:

    How to make a training pipeline in UbiOps which preprocesses the data and trains and tests a KNN model using scikit

    How to make a production pipeline in UbiOps which takes in new data, processes it and feeds it to a trained model for prediction/classification


```

* Duplicated the python folder structure in other folder
* also copied the files.

```
The training pipeline¶

The training pipeline takes the diabetes data set as input and trains a KNN classifier. It is made up of the following deployments:

Model 	            Function
-------------------|-------------------------------------------
data-preprocessor 	Cleans the input data
model-training 	    Trains a KNN classifier to predict diabetes
```



```
The production pipeline¶

The production pipeline takes in new data, cleans it and feeds it to a trained KNN classifier. It is made up of the following deployments:

Model 	            Function
-------------------|-------------------------------------------
data-preprocessor 	Cleans the input data
knn-model 	        Predicts diabetes instances
```


checking out the deployment file of python preprocessing package: 

  * imports [scikitlearn standard scaler](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html) standardizes features to mean 0 sd 1
  * loads data via the 'data' slot input 
  * replace zeros in 'Glucose','BloodPressure','SkinThickness','Insulin','BMI' with NA
  * print "Imputing missing values"
  * inpute mean glucose
  * inpute mean bloodpressure
  * inpute median skinthickness
  * inpute median insulin
  * inpute median BMI
  * if 'training' is true split outcode from trainingset, otherwise fill y with 1's
  * print("Scaling data")
  * standardize 'Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin','BMI', 'DiabetesPedigreeFunction', 'Age' 
  * create 'X.csv' with trainingdata and 'y.csv' without headings
  * return "cleaned_data": 'X.csv', "target_data": 'y.csv'
  
* create a new R project inside the preprocessing_package
  * see that project
* create new Rstudio project for training
  * see that project
  
  
(It doesn't really make sense to split the y from the X, as they do here but 
I'll just follow along)

I think, with renv as centrepiece, you need to create a project for each deployment package.
that makes sense to me in the logic as well, you can create and maintain them all independently. possibly with a seperate git repo too. 

* created pipeline through webinterface
* cannot see the blobid of model through interface.
* updated the thingy