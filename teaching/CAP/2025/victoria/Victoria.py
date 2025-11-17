#*  ***************************************************************** *
#*  ***************************************************************** *
#*     File-Name:   Victoria.py                                       *
#*     Author:      Eddie Hearn                                       *
#*     Purpose:     Victoria 2025 (analysis)                          *
#*     Input File:  results.csv                                       *                                             
#*     Outputfile:                                                    *
#*     Program:	   Python 3.13.5                                      *
#*     OS:		   Debian GNU/Linux                                   *
#*  ****************************************************************  *
#*  ****************************************************************  *

import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
from pandas.api.types import CategoricalDtype
import os
import numpy as np

# move to working directory
os.chdir("C:/Users/mtgro/CAPSTONE_DATA/python")

		
#### LOAD DATA USING PANDAS

df=pd.read_csv('results.csv')

#### First lets makes some grapsh of the distribution of our variables 

# Loop through each column in the DataFrame
for column in df.columns:
    plt.figure(figsize=(8, 6)) 
    sns.countplot(data=df, x=column) 
    plt.title(f'Distribution of {column}') 
    plt.xlabel(column) 
    plt.ylabel('Frequency') 
    plt.savefig(f'graphs/{column}.png')


### Now we will make the political ideology variable
conditions_list = [
    (df['con'] < 12),        
    (df['con'] > 14)  
]

ideo_list = ['Liberal', 'Conservative']

df['ideology3'] = np.select(conditions_list, ideo_list, default='Nuetral')

dv_list = ['conservative_neutral_text', 'conservative_emotional_text', 'liberal_neutral_text', 'liberal_emotional_text'] 

for variable in dv_list:
    plt.figure(figsize=(8, 6)) 
    sns.barplot(data=df, y=variable, hue="ideology3", palette="pastel" ) 
    plt.title(f'{variable.capitalize()}') 
    plt.xlabel(f'{variable.capitalize()}')
    plt.ylabel('Count')
    plt.title(f'RESULT_{variable}') 
    plt.savefig(f'graphs/RESULT_{variable}.png')

