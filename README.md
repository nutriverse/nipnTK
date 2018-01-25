
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nipnTK: National Information Platforms for Nutrition (NiPN) data quality toolkit

[![CRAN](https://img.shields.io/cran/v/nipnTK.svg)](https://cran.r-project.org/package=nipnTK)
[![CRAN](https://img.shields.io/cran/l/nipnTK.svg)](https://CRAN.R-project.org/package=nipnTK)
[![CRAN](http://cranlogs.r-pkg.org/badges/nipnTK)](https://cran.r-project.org/package=nipnTK)
[![Travis-CI Build
Status](https://travis-ci.org/validmeasures/nipnTK.svg?branch=master)](https://travis-ci.org/validmeasures/nipnTK)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/validmeasures/nipnTK?branch=master&svg=true)](https://ci.appveyor.com/project/validmeasures/nipnTK)
[![codecov](https://codecov.io/gh/validmeasures/nipnTK/branch/master/graph/badge.svg)](https://codecov.io/gh/validmeasures/nipnTK)

[National Information Platforms for Nutrition
(NIPN)](http://www.nipn-nutrition-platforms.org) is an initiative of the
European Commission to provide support to countries to strengthen their
information systems for nutrition and to improve the analysis of data so
as to better inform the strategic decisions they are faced with to
prevent malnutrition and its consequences.

As part of this mandate, NiPN has commissioned work on the development
of a toolkit to assess the quality of various nutrition-specific and
nutrition-related data. This is a companion R package to the toolkit of
practical analytical methods that can be applied to variables in
datasets to assess their quality.

The focus of the toolkit is on data required to assess anthropometric
status such as measurements of weight, height or length, MUAC, sex and
age. The focus is on anthropometric status but many of presented methods
could be applied to other types of data. NiPN may commission additional
toolkits to examine other variables or other types of variables.

## Requirements

  - R version 3.4 or higher

Extensive use is made of the R language and environment for statistical
computing. This is a free and powerful data analysis system. R provides
a very extensive language for working with data. This companion package
has been written using only a small subset of the R language. Many of
the data quality activities described in the toolkit are supported by R
functions included in this package that have been written specifically
for this purpose. These simplify the assessment of the quality of data
related to anthropometry and anthropometric indices.

## Installation

You can install the development version of nipnTK from github with:

``` r
# install.packages("devtools")
devtools::install_github("validmeasures/nipnTK")
```
