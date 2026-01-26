# [`print()`](https://rdrr.io/r/base/print.html) helper functions for [`ageHeaping()`](https://nutriverse.io/nipnTK/reference/ageHeaping.md) functions

[`print()`](https://rdrr.io/r/base/print.html) helper functions for
[`ageHeaping()`](https://nutriverse.io/nipnTK/reference/ageHeaping.md)
functions

## Usage

``` r
# S3 method for class 'ageHeaping'
print(x, ...)
```

## Arguments

- x:

  Object resulting from applying the
  [`ageHeaping()`](https://nutriverse.io/nipnTK/reference/ageHeaping.md)
  function

- ...:

  Additional [`print()`](https://rdrr.io/r/base/print.html) arguments

## Value

Printed output of the
[`ageHeaping()`](https://nutriverse.io/nipnTK/reference/ageHeaping.md)
function

## Examples

``` r
# Print age heaping test on SMART survey data in Kabul, Afghanistan (dp.ex02)
# using a divisor of 12
svy <- dp.ex02
ah12 <- ageHeaping(svy$age)
print(ah12)
#> 
#>  Age-heaping Analysis
#> 
#> data:    Remainder of svy$age / 12
#> X-squared = 214.9588, df = 11, p-value = 0.0000
#> 
```
