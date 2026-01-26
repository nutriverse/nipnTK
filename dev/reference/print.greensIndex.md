# [`print()`](https://rdrr.io/r/base/print.html) helper function for `print.greensIndex()` function

[`print()`](https://rdrr.io/r/base/print.html) helper function for
`print.greensIndex()` function

## Usage

``` r
# S3 method for class 'greensIndex'
print(x, ...)
```

## Arguments

- x:

  Object resulting from applying the
  [`greensIndex()`](https://nutriverse.io/nipnTK/dev/reference/greensIndex.md)
  function

- ...:

  Additional [`print()`](https://rdrr.io/r/base/print.html) parameters

## Value

Printed output of
[`greensIndex()`](https://nutriverse.io/nipnTK/dev/reference/greensIndex.md)
function

## Examples

``` r
# Apply Green's Index using anthropometric data from a SMART survey in Sudan
# (flag.ex01)
svy <- flag.ex01
svy$flag <- 0
svy$flag <- ifelse(!is.na(svy$haz) & (svy$haz < -6 | svy$haz > 6), svy$flag + 1, svy$flag)
svy$flag <- ifelse(!is.na(svy$whz) & (svy$whz < -5 | svy$whz > 5), svy$flag + 2, svy$flag)
svy$flag <- ifelse(!is.na(svy$waz) & (svy$waz < -6 | svy$waz > 5), svy$flag + 4, svy$flag)
svy <- svy[svy$flag == 0, ]
svy$stunted <- ifelse(svy$haz < -2, 1, 2)
gi <- greensIndex(data = svy, psu = "psu", case = "stunted")
print(gi)
#> 
#>  Green's Index of Dispersion
#> 
#> Green's Index (GI) of Dispersion  = -0.0013, 95% CI = (-0.0021, -0.0004)
#> Maximum uniformity for this data  = -0.0035
#>                          p-value  =  0.0020
#> 
```
