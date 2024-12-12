cp https://eddie-hearn.github.io/teaching/ZEM/datasets/sentiment.csv sentiment.csv, replace
cp https://eddie-hearn.github.io/teaching/ZEM/datasets/sotu_meta.csv sotu_meta.csv , replace 
shell pip install plotly pandas

import delim sotu_meta.csv
save sotu_meta, replace
clear
import delim sentiment.csv
drop v1
merge 1:1 count using sotu_meta
drop _merge

gen polarity = (pos - neg)/(pos + neg)
gen size = 40
sum year
local max = `r(max)'

gen party2 = "Other"
replace party2 = "Democratic" if party == "Democratic"
replace party2 = "Republican" if party == "Republican"

export delim "sotu.csv", replace

python
import plotly.express as px
import pandas as pd

df = pd.read_csv('sotu.csv')
df.polarity = df.polarity.round(2)
fig = px.scatter(df, x="year", y="polarity", color="party2", hover_data='president', size="size", trendline="ols", trendline_scope="overall",
    labels={
        "year": "Year",
        "president": "President",
        "party2": "Party"},
    title="Polarity of SOTU")

fig.update_layout(
    template="plotly_white",
    font=dict(family="Courier New, monospace", size=30, color="RebeccaPurple"))

fig.write_html("sotu.html")


end

