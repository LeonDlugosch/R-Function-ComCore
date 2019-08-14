# R-Function: com_core()
Functions to easily identify shared features in samples of differend groups (eg. experimental conditions or environments).
Outputs a venn-diagram or data frame. 

## Usage
```
com_core(df, groups, input = "abundance", min = 0.01, output = "plot")
```
### Full List of options
```
df        dataframe or matrix containing count or abundance (%) data of sample features (e.g. species, ASWs, OTUs, compounds, etc.)
groups    vector of group (e.g. treament, environmental type) each sample belongs to. Must contain an entry for every sample.
input     specify if input is a count or abundance table
min       minimum share of total sample abundance of each feature to be counted as "present" in percent. default = 0.01
output    toggle to set output type. use "plot" to plot a venn diagram or "table" to generate a table of shared features.
```
