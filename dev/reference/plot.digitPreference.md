# [`plot()`](https://rdrr.io/r/graphics/plot.default.html) helper function for [`digitPreference()`](https://nutriverse.io/nipnTK/dev/reference/digitPreference.md) function

[`plot()`](https://rdrr.io/r/graphics/plot.default.html) helper function
for
[`digitPreference()`](https://nutriverse.io/nipnTK/dev/reference/digitPreference.md)
function

## Usage

``` r
# S3 method for class 'digitPreference'
plot(x, main = "", xlab = "Final Digit", ylab = "Frequency", cex = 0.75, ...)
```

## Arguments

- x:

  Object resulting from applying the
  [`digitPreference()`](https://nutriverse.io/nipnTK/dev/reference/digitPreference.md)
  function.

- main:

  Title of plot

- xlab:

  `x-axis` label; default is "Final Digit"

- ylab:

  `y-axis` label; default is "Frequency"

- cex:

  Character expansion; default is 0.75

- ...:

  Additional [`plot()`](https://rdrr.io/r/graphics/plot.default.html)
  parameters

## Value

Plotted output of
[`digitPreference()`](https://nutriverse.io/nipnTK/dev/reference/digitPreference.md)
function comparing the frequencies of the various final digits

## Examples

``` r
# Plot output of digit preference test applied to anthropometric data from a
# single state from a DHS survey in a West African country
svy <- dp.ex01
digitPreference(svy$wt, digits = 1)
#> 
#>  Digit Preference Score
#> 
#> data:    svy$wt
#> Digit Preference Score (DPS) = 11.86 (Good)
#> 
plot(digitPreference(svy$wt, digits = 1))

```
