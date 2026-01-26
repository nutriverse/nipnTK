# [`plot()`](https://rdrr.io/r/graphics/plot.default.html) helper functions for [`ageHeaping()`](https://nutriverse.io/nipnTK/reference/ageHeaping.md) functions

[`plot()`](https://rdrr.io/r/graphics/plot.default.html) helper
functions for
[`ageHeaping()`](https://nutriverse.io/nipnTK/reference/ageHeaping.md)
functions

## Usage

``` r
# S3 method for class 'ageHeaping'
plot(x, main = "", xlab = "Remainder", ylab = "Frequency", cex = 0.75, ...)
```

## Arguments

- x:

  Object resulting from applying the
  [`ageHeaping()`](https://nutriverse.io/nipnTK/reference/ageHeaping.md)
  function

- main:

  Title of plot

- xlab:

  `x-axis` label; default is `Remainder`

- ylab:

  `y-axis` label; default is `Frequency`

- cex:

  Character expansion (numeric); default is 0.75

- ...:

  Additional [`plot()`](https://rdrr.io/r/graphics/plot.default.html)
  graphical parameters

## Value

Barplot of frequency of remainders of age when divided by a specified
divisor

## Examples

``` r
# Plot age heaping test results on SMART survey data in Kabul, Afghanistan
# (dp.ex02) using a divisor of 12
svy <- dp.ex02
ah12 <- ageHeaping(svy$age)
plot(ah12)

```
