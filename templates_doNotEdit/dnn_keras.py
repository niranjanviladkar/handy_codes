import numpy as np
import pandas as pd
import time

from sklearn import metrics, tree
import matplotlib.pyplot as plt

# from keras import load_model
from keras.models import Sequential
from keras.layers import Dense, Dropout

seed = 123456
np.random.seed(seed)  # use `seed' variable to set seeds in the code


df = pd.read_csv(filepath_or_buffer="./sample_data.csv",
                 true_values='TRUE',
                 false_values='FALSE')

df.Size = df.Size.astype('category')

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
        elif (   unique_count < threshold
              or dataframe[col].dtype == 'object'
              or dataframe[col].dtype == 'bool'
              or dataframe[col].dtype == 'str'):
                 categorical_similar_value.append(col)

    print("Number of columns with single value : {}".format(len(single_value)))
    print("Number of columns with categorical or similar value : {}".format(
            len(categorical_similar_value)))

    return single_value, categorical_similar_value

singles, cats = variable_explorer(df, 10)

for col in cats:
    vc_percent = np.around(pd.DataFrame(df[col].value_counts(
            normalize=True, sort=True, dropna=False)) * 100.0, 2)
    vc_numbers = pd.DataFrame(df[col].value_counts(
            normalize=False, sort=True, dropna=False))
    print(pd.concat([vc_percent, vc_numbers], axis=1))
    print("")


null_cols = df.columns[df.isnull().any()].tolist()
