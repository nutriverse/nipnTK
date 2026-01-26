# [`print()`](https://rdrr.io/r/base/print.html) helper function for [`ageChildren()`](https://nutriverse.io/nipnTK/dev/reference/ageChildren.md) function

[`print()`](https://rdrr.io/r/base/print.html) helper function for
[`ageChildren()`](https://nutriverse.io/nipnTK/dev/reference/ageChildren.md)
function

## Usage

``` r
# S3 method for class 'ageChildren'
print(x, ...)
```

## Arguments

- x:

  Object resulting from applying
  [`ageChildren()`](https://nutriverse.io/nipnTK/dev/reference/ageChildren.md)
  function

- ...:

  Additional [`print()`](https://rdrr.io/r/base/print.html) arguments

## Value

Printed output of
[`ageChildren()`](https://nutriverse.io/nipnTK/dev/reference/ageChildren.md)
function

## Examples

``` r
# Print Chi-Squared test for age of children in dp.ex02 sample dataset using
# an u5mr of 1 / 10,000 / day.
svy <- dp.ex02
ac <- ageChildren(svy$age, u5mr = 1)
print(ac)
#> 
#>  Age Test (Children)
#> 
#> X-squared = 21.4366, df = 4, p = 0.0003
#> 
```
