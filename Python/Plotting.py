
#################################################################

# loading python libraries

#################################################################

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


###############################################################

# loading well data

###############################################################


df = pd.read_csv("Well_all.csv")


###############################################################

# Plot paired relationships from a dataset.

###############################################################


sns.pairplot(df, hue="FACIES", diag_kind='kde')

plt.savefig("pairplot.jpg", bbox_inches='tight', pad_inches=0.0)

plt.show()


#####################################################################

# Correlation_mat

####################################################################


correlation_mat = df.corr()

sns.heatmap(correlation_mat, annot=True, vmax=1, vmin=-1, center=0)

mask = np.triu(np.ones_like(correlation_mat, dtype=bool))

f, ax = plt.subplots(figsize=(11, 9))

cmap = sns.diverging_palette(230, 20, as_cmap=True)

sns.heatmap(correlation_mat, annot=True, vmax=1, vmin=-1, center=0, cmap=cmap)

plt.title("Correlation matrix of Well log data")

plt.xlabel("Well log data")

plt.ylabel("Well log data")

plt.savefig("Correlation matrix.jpg", bbox_inches='tight', pad_inches=0.0)

plt.show()

plt.close()


####################################################################

# Dataframe static analysis

####################################################################


df.describe()

y = df.describe()

y.to_csv("describe_facies.csv")


####################################################################





