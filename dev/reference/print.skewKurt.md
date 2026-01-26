# [`print()`](https://rdrr.io/r/base/print.html) helper function for [`skewKurt()`](https://nutriverse.io/nipnTK/dev/reference/skewKurt.md) function

[`print()`](https://rdrr.io/r/base/print.html) helper function for
[`skewKurt()`](https://nutriverse.io/nipnTK/dev/reference/skewKurt.md)
function

## Usage

``` r
# S3 method for class 'skewKurt'
print(x, ...)
```

## Arguments

- x:

  Object resulting from applying the
  [`skewKurt()`](https://nutriverse.io/nipnTK/dev/reference/skewKurt.md)
  function

- ...:

  Additional [`print()`](https://rdrr.io/r/base/print.html) parameters

## Value

Printed output of
[`skewKurt()`](https://nutriverse.io/nipnTK/dev/reference/skewKurt.md)
function

## Examples

``` r
# Use skewKurt() on an anthropometric data from a SMART survey in
# Kabul, Afghanistan (dist.ex01)
svy <- dist.ex01
sk <- skewKurt(svy$muac)
print(sk)
#> 
#>  Skewness and kurtosis
#> 
#> Skewness = +0.0525   SE = 0.0828 z = 0.6348  p = 0.5256
#> Kurtosis = -0.2412   SE = 0.1653 z = 1.4586  p = 0.1447
#> 
```
