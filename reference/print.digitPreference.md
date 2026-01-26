# [`print()`](https://rdrr.io/r/base/print.html) helper function for [`digitPreference()`](https://nutriverse.io/nipnTK/reference/digitPreference.md) function

[`print()`](https://rdrr.io/r/base/print.html) helper function for
[`digitPreference()`](https://nutriverse.io/nipnTK/reference/digitPreference.md)
function

## Usage

``` r
# S3 method for class 'digitPreference'
print(x, ...)
```

## Arguments

- x:

  Object resulting from applying the
  [`digitPreference()`](https://nutriverse.io/nipnTK/reference/digitPreference.md)
  function.

- ...:

  Additional [`print()`](https://rdrr.io/r/base/print.html) parameters

## Value

Printed output of
[`digitPreference()`](https://nutriverse.io/nipnTK/reference/digitPreference.md)
function

## Examples

``` r
# Print output of digit preference test applied to anthropometric data from a
#single state from a DHS survey in a West African country
svy <- dp.ex01
print(digitPreference(svy$wt, digits = 1))
#> 
#>  Digit Preference Score
#> 
#> data:    svy$wt
#> Digit Preference Score (DPS) = 11.86 (Good)
#> 
```
