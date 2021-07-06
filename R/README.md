## R code examples

This folder contains three project that form R equivalent code to the example
python pipelines [described in the UbiOps cookbook](https://ubiops.com/docs/ubiops_cookbook/scikit-deployment/index.html)

Described in blogpost:  [Walkthrough UbiOps and Tidymodels](https://blog.rmhogervorst.nl/blog/2021/07/06/walkthrough-ubiops-and-tidymodels/)

The three components are:

- [preprocessing_package](preprocessing_package): which turns 0s in certain vairables into missings, replaces those with the means or medians, and standardizes/normalizes the values 
- [training_package](training_package): trains a k-nearest (k=7) neighbors model on data going in
- [predictor_package](predictor_package): predicts new cases based on trained model

The UbiOps platform takes care of installing packages as long as you specify them with an install script or use  the {renv} package.



License: MIT
