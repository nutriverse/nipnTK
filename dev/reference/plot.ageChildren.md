# Plot helper function for [`ageChildren()`](https://nutriverse.io/nipnTK/dev/reference/ageChildren.md) function

Plot helper function for
[`ageChildren()`](https://nutriverse.io/nipnTK/dev/reference/ageChildren.md)
function

## Usage

``` r
# S3 method for class 'ageChildren'
plot(x, ...)
```

## Arguments

- x:

  Object resulting from applying
  [`ageChildren()`](https://nutriverse.io/nipnTK/dev/reference/ageChildren.md)
  function

- ...:

  Additional [`barplot()`](https://rdrr.io/r/graphics/barplot.html)
  graphical parameters

## Value

Bar plot comparing table of observed counts vs table of expected counts

## Examples

``` r
# Plot Chi-Squared test for age of children in dp.ex02 sample dataset using
# an u5mr of 1 / 10,000 / day.
svy <- dp.ex02
ac <- ageChildren(svy$age, u5mr = 1)
plot(ac)

```
