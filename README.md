
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nipnTK: National Information Platforms for Nutrition (NiPN) Data Quality Toolkit <img src="man/figures/logo.png" width="200px" align="right" display="none" />

<!-- Badges start here -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN](https://img.shields.io/cran/v/nipnTK.svg)](https://cran.r-project.org/package=nipnTK)
[![cran
checks](https://badges.cranchecks.info/worst/nipnTK.svg)](https://cran.r-project.org/web/checks/check_results_nipnTK.html)
[![CRAN](https://img.shields.io/cran/l/nipnTK.svg)](https://CRAN.R-project.org/package=nipnTK)
[![CRAN](http://cranlogs.r-pkg.org/badges/nipnTK)](https://cran.r-project.org/package=nipnTK)
[![CRAN](http://cranlogs.r-pkg.org/badges/grand-total/nipnTK)](https://cran.r-project.org/package=nipnTK)
[![R-CMD-check](https://github.com/nutriverse/nipnTK/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/nutriverse/nipnTK/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/nutriverse/nipnTK/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/nutriverse/nipnTK/actions/workflows/test-coverage.yaml)
[![Codecov test
coverage](https://codecov.io/gh/nutriverse/nipnTK/branch/main/graph/badge.svg)](https://app.codecov.io/gh/nutriverse/nipnTK?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/nutriverse/nipntk/badge)](https://www.codefactor.io/repository/github/nutriverse/nipntk)
[![DOI](https://zenodo.org/badge/118171028.svg)](https://zenodo.org/badge/latestdoi/118171028)
<!-- Badges end here -->

[National Information Platforms for Nutrition
(NiPN)](https://www.nipn-nutrition-platforms.org) is an initiative of
the European Commission to provide support to countries to strengthen
their information systems for nutrition and to improve the analysis of
data so as to better inform the strategic decisions they are faced with
to prevent malnutrition and its consequences.

As part of this mandate,
[NiPN](https://www.nipn-nutrition-platforms.org) has commissioned work
on the development of a toolkit to assess the quality of various
nutrition-specific and nutrition-related data. This is a companion R
package to the toolkit of practical analytical methods that can be
applied to variables in datasets to assess their quality.

The focus of the toolkit is on data required to assess anthropometric
status such as measurements of weight, height or length, MUAC, sex and
age. The focus is on anthropometric status but many of presented methods
could be applied to other types of data.
[NiPN](https://www.nipn-nutrition-platforms.org) may commission
additional toolkits to examine other variables or other types of
variables.

## Installation

You can install `nipnTK` from [CRAN](https://cran.r-project.org):

``` r
install.packages("nipnTK")
```

You can install the development version of `nipnTK` from
[GitHub](https://github.com/nutriverse/nipnTK) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("nutriverse/nipnTK")
```

## Usage

Data quality is assessed by:

1.  Range checks and value checks to identify *univariate* outliers -
    [guide](https://nutriverse.io/nipnTK/articles/rl.html)

2.  Scatterplots and statistical methods to identify *bivariate*
    outliers - [guide](https://nutriverse.io/nipnTK/articles/sp.html)

3.  Use of flags to identify outliers in anthropometric indices -
    [guide](https://nutriverse.io/nipnTK/articles/flagging.html)

4.  Examining the distribution and the statistics of the distribution of
    measurements and anthropometric indices -
    [guide](https://nutriverse.io/nipnTK/articles/ad.html)

5.  Assessing the extent of digit preference in recorded measurements -
    [guide](https://nutriverse.io/nipnTK/articles/dp.html)

6.  Assessing the extent of age heaping in recorded ages -
    [guide](https://nutriverse.io/nipnTK/articles/ah.html)

7.  Examining the sex ratio -
    [guide](https://nutriverse.io/nipnTK/articles/sr.html)

8.  Examining age distributions and age by sex distributions -
    [guide](https://nutriverse.io/nipnTK/articles/as.html)

These activities and a proposed order in which they should be performed
are shown below:

<img src="man/figures/nipnWorkflow.png" width="918" />

## Citation

If you find the `nipnTK` package useful, please cite using the suggested
citation provided by a call to the `citation` function as follows:

``` r
citation("nipnTK")
#> To cite nipnTK in publications use:
#> 
#>   Mark Myatt, Ernest Guevarra (2024). _nipnTK: National Information
#>   Platforms for Nutrition (NiPN) Data Quality Toolkit_.
#>   doi:10.5281/zenodo.4297897 <https://doi.org/10.5281/zenodo.4297897>,
#>   R package version 0.2.0, <https://nutriverse.io/nipnTK/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {nipnTK: National Information Platforms for Nutrition (NiPN) Data Quality Toolkit},
#>     author = {{Mark Myatt} and {Ernest Guevarra}},
#>     year = {2024},
#>     note = {R package version 0.2.0},
#>     url = {https://nutriverse.io/nipnTK/},
#>     doi = {10.5281/zenodo.4297897},
#>   }
```

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/nutriverse/nipnTK/issues). If you
would like to contribute to the package, please see our [contributing
guidelines](https://nutriverse.io/nipnTK/CONTRIBUTING.html).

This project is released with a [Contributor Code of
Conduct](https://nutriverse.io/nipnTK/CODE_OF_CONDUCT.html). By
participating in this project you agree to abide by its terms.
