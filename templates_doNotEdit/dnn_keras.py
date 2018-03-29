import numpy as np
import pandas as pd

from sklearn import metrics, tree
import matplotlib.pyplot as plt

seed = 123456
np.random.seed(seed)  # use `seed' variable to set seeds in the code

from keras import load_model
from keras.models import Sequential
from keras.layers import Dense, Dropout
import time


df = pd.DataFrame() # TODO(Add code to read/create your data frame here)

print(df.shape)

def variable_explorer(dataframe, threshold):
    """
    Explore a pandas dataframe.

    and return list od single value and categorical
    variables based on threshold and data type.

    Args:
        dataframe: a pandas dataframe
        threshold: min number of unique values for any continuous variable
        to be considered as continous. Id less unique values, such continuous
        variable is considered as 'categorical_similar'
    """
    single_value = []
    categorical_similar_value = []

    for col in dataframe.columns:
        unique_count = len(list(dataframe[col].unique()))
        if unique_count == 1:
            single_value.append(col)
        elif unique_count < threshold \
             or dataframe[col].dtype == 'object' \
             or dataframe[col].dtype == 'bool' \
             or dataframe[col].dtype == 'str':
                 categorical_similar_value.append(col)

    print("Number of columns with single value : {}".format(len(single_value)))
    print("Number of columns with categorical or similar value : {}".format(
            len(categorical_similar_value)))

    return single_value, categorical_similar_value