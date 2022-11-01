#################################################################

# Loading python libraries

#################################################################

import numpy as np
import pandas as pd
import lasio
import os


#################################################################

# Loading well data

#################################################################

df_dict = {}
las_dir = "./Dados"
for lasfile in os.listdir(las_dir):
    if lasfile.startswith("EN_"):
        las = lasio.read(os.path.join(las_dir,lasfile))
        lasdf = las.df()
        lasdf['WELL'] = las.well.WELL.value
        lasdf['DEPTH'] = lasdf.index
        df_dict[las.well.WELL.value] = lasdf
        print(las.well.WELL.value)

#################################################################

# Select Columns

#################################################################

select_columns = ["DEPTH","WELL","SONICO","GAMMARAY","RESISTIVITY","NEUTRON","DENSITY","PERMEABILITY","POROSITY-EFFECTIVE","FACIES"]
for well, data in df_dict.items():
    print(well)
    data = data[select_columns]
    data = data.dropna()
    print(data.shape)
    df_dict[well] = data


#################################################################

# Concatenate well data to get a single dataframe

#################################################################

list_df = [df for key,df in df_dict.items()]
df_todos = pd.concat(list_df,ignore_index=True)
df_todos.shape


#################################################################

# Preparing well log data

#################################################################

# Transfer resistivity to log

df_todos['RESISTIVITY_log'] = np.log(df_todos['RESISTIVITY'])

# Transfer neutron to decimal

df_todos['NEUTRON'] = df_todos['NEUTRON']/100

# Rename porosity

df_todos.rename({"POROSITY-EFFECTIVE":"POROSITY"},axis=1, inplace=True)

####################################################

# Save final results in CSV file

####################################################


df_todos.to_csv("Well_all.csv")


####################################################












