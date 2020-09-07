# CONTRIBUTING
Please contribute!
We love collaboration.

## Bugs? Feature requests?
Submit an issue on the [issues page](https://github.com/Hong-Kong-Districts-Info/hkdatasets/issues)

## Code contributions
I would prefer some discussion before an unsolicited code contribution, i.e., pull request. 

This ensures that your effort is not wasted and that we're aligned on how to improve the **hkdatasets** package.

This is especially true if your proposed contribution does not match a currently open issue.

If that's the case, please open new issue(s) to have the discussion there, prior to submitting code.

If your proposed contribution addresses multiple issues, it should ideally be broken into multiple pull requests. This will make it easier for me to review and approve.

## The mechanics of contributing:
1. Fork this repo to your Github account
1. Clone your version on your account down to your machine from your account, e.g,. git clone https://github.com/<yourgithubusername>/hkdatasets.git
1. Make sure to track progress upstream (i.e., on our version of hkdatasets at Hong-Kong-Districts-Info/hkdatasets) by doing git remote add upstream https://github.com/Hong-Kong-Districts-Info/hkdatasets.git. Before making changes, make sure to pull changes in from upstream by doing either `git fetch upstream` then merge later or `git pull upstream` to fetch and merge in one step
1. Make your changes (bonus points for making changes on a new feature branch)
1. Push up to your account
1. Submit a pull request to the master branch at Hong-Kong-Districts-Info/hkdatasets.git
  
## How to add a dataset
1. Open the `RProj` file, and ensure that your current working directory is set to the directory of the package repository.
1. Read the dataset you'd like to add into your current environment, and make any data cleaning or manipulations necessary. We would recommend you to save any processing scripts in `.dev/script` and any raw data in `.dev/data`.
1. Once you are happy to add the dataset to the package, run `usethis::use_data()`, passing the unquoted object to save in the argument. If this runs successfully, a `.rda` file should be set up in the package repository. You will be asked to document your dataset. 
1. Add a R file in the `R` directory with the same name as your dataset. Use one of the existing R files as a template for the documentation.
1. Once you are happy with everything, run `roxygen2::roxygenise()`. This will create the documentation files and notify you of any errors. 
1. Run `devtools::check()`. This will run `R CMD` checks to ensure that the package can be built properly.
1. You can run `devtools::install()` to install the package on your local machine. You can also commit your changes and push to the repository once you are happy.

## Prefer to discuss over email?
Please email hkdistricts.info@gmail.com.

Thanks for contributing!
