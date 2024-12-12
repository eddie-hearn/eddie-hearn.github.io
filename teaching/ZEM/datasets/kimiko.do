cp https://eddie-hearn.github.io/teaching/ZEM/datasets/sex-education.csv sex-education.csv , replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/state-dem.csv state-dem.csv , replace 

import delim state-dem.csv
save state-dem.dta, replace
clear

import delim sex-education.csv

merge m:1 state using state-dem
keep if _merge==3
drop _merge

export delim "std.csv", replace
shell pip install plotly pandas

python
import plotly.express as px
import pandas as pd

df = pd.read_csv('std.csv')
fig = px.scatter(df, x="sex_education_grade", size="gdp_per", color="black_per", y="std_per100000", hover_data='state', trendline="ols",
    labels={
        "sex_education_grade": "Sex education",
        "std_per100000": "STD rate",
        "state": "State"},
    title="Sex education and STD rate")

fig.update_layout(
    template="plotly_white",
    font=dict(family="Courier New, monospace", size=40, color="RebeccaPurple"))

fig.write_html("educ.html")

fig = px.scatter(df, color="sex_education_grade", size="gdp_per", x="black_per", y="std_per100000", hover_data='state', trendline="ols",
    labels={
        "sex_education_grade": "Sex education",
        "std_per100000": "STD rate",
        "state": "State"},
    title="Race and STD rate")

fig.update_layout(
    template="plotly_white",
    font=dict(family="Courier New, monospace", size=40, color="RebeccaPurple"))

fig.write_html("ethno.html")

fig = px.scatter(df, color="sex_education_grade", x="gdp_per", size="black_per", y="std_per100000", hover_data='state', trendline="ols",
    labels={
        "sex_education_grade": "Sex education",
        "std_per100000": "STD rate",
        "state": "State"},
    title="Income and STD rate")

fig.update_layout(
    template="plotly_white",
    font=dict(family="Courier New, monospace", size=40, color="RebeccaPurple"))

fig.write_html("income.html")


end
