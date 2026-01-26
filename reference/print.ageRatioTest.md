# [`print()`](https://rdrr.io/r/base/print.html) helper function for [`ageRatioTest()`](https://nutriverse.io/nipnTK/reference/ageRatioTest.md) function

[`print()`](https://rdrr.io/r/base/print.html) helper function for
[`ageRatioTest()`](https://nutriverse.io/nipnTK/reference/ageRatioTest.md)
function

## Usage

``` r
# S3 method for class 'ageRatioTest'
print(x, ...)
```

## Arguments

- x:

  Object resulting from applying
  [`ageRatioTest()`](https://nutriverse.io/nipnTK/reference/ageRatioTest.md)
  function

- ...:

  Additional [`print()`](https://rdrr.io/r/base/print.html) arguments

## Value

Printed output of
[`ageRatioTest()`](https://nutriverse.io/nipnTK/reference/ageRatioTest.md)
function

## Examples

``` r
# Print age-ratio test results for survey dataset from Kabul, Afghanistan
svy <- dp.ex02
print(ageRatioTest(svy$age, ratio = 0.85))
#> 
#>      Age Ratio Test (children's data)
#> 
#>                     Expected age ratio = 0.8500
#> Expected proportion aged 6 - 29 months = 0.4595
#> 
#>                     Observed age ratio = 0.8654
#> Observed proportion aged 6 - 29 months = 0.4639
#> 
#> X-squared = 0.0531, p = 0.8178
#> 
```
