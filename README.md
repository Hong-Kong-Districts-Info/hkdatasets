# hkdatasets
An R data package containing datasets relating to Hong Kong

[![R build status](https://github.com/Hong-Kong-Districts-Info/hkdatasets/workflows/R-CMD-check/badge.svg)](https://github.com/Hong-Kong-Districts-Info/hkdatasets/actions)

### Introduction

This package contains datasets on Hong Kong. This package is developed as part of the Hong Kong Districts Info group of projects, which is dedicated to using data science to help make public information more accessible and consumable. The package contains the following datasets:

- `hkdc` - A dataset containing information about Hong Kong District Councillors (elected 2019), with variables such as their constituency, region, share of vote, total votes, link to their Facebook pages, etc. (Sources: https://www.districtcouncils.gov.hk; https://dce2019.hk01.com/)

### Installation

{hkdatasets} is not release on CRAN (yet). 
You can install the latest development version from GitHub with:

```
install.packages("devtools")
devtools::install_github("Hong-Kong-Districts-Info/hkdatasets")
```

### Datasets

If you are exploring the package, we recommend starting with 2019 District Councillors dataset:

```
library(hkdatasets)
head(hkdc)
```
To find out more about the variable and the source of the dataset, you can run:
```
?hkdc
```

### Contact
Please feel free to submit suggestions and report bugs: https://github.com/Hong-Kong-Districts-Info/hkdatasets/issues

Also check out our [website](https://hong-kong-districts-info.github.io/) for our other work and projects!
