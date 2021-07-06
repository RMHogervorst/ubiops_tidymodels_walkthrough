## R code examples

This folder contains three project that form R equivalent code to the example
python pipelines [described in the UbiOps cookbook](https://ubiops.com/docs/ubiops_cookbook/scikit-deployment/index.html)

Described in blogpost:  LINK HERE

The three components are:

- [preprocessing_package](preprocessing_package): which turns 0s in certain vairables into missings, replaces those with the means or medians, and standardizes/normalizes the values 
- [training_package](training_package): trains a k-nearest (k=7) neighbors model on data going in
- [predictor_package](predictor_package): predicts new cases based on trained model


License: MIT
