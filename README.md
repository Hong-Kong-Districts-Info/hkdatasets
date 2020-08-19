# hkdatasets
An R data package containing datasets relating to Hong Kong

[![R build status](https://github.com/Hong-Kong-Districts-Info/hkdatasets/workflows/R-CMD-check/badge.svg)](https://github.com/Hong-Kong-Districts-Info/hkdatasets/actions)

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
