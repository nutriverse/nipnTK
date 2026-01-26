# [`print()`](https://rdrr.io/r/base/print.html) helper function for [`sexRatioTest()`](https://nutriverse.io/nipnTK/dev/reference/sexRatioTest.md) function

[`print()`](https://rdrr.io/r/base/print.html) helper function for
[`sexRatioTest()`](https://nutriverse.io/nipnTK/dev/reference/sexRatioTest.md)
function

## Usage

``` r
# S3 method for class 'sexRatioTest'
print(x, ...)
```

## Arguments

- x:

  Output resulting from applying the
  [`sexRatioTest()`](https://nutriverse.io/nipnTK/dev/reference/sexRatioTest.md)
  function

- ...:

  Additional [`print()`](https://rdrr.io/r/base/print.html) parameters

## Value

Printed output of
[`sexRatioTest()`](https://nutriverse.io/nipnTK/dev/reference/sexRatioTest.md)
function

## Examples

``` r
# Use sexRatioTest() on household roster data from a survey in Tanzania
# (as.ex01) and census data of Tanzania extracted from Wolfram|Alpha knowledge
# engine (as.ex02)
svy <- as.ex01
ref <- as.ex02
censusM <- sum(ref$Males)
censusF <- sum(ref$Females)
srt <- sexRatioTest(svy$sex, codes = c(1, 2), pop = c(censusM, censusF))
print(srt)
#> 
#>  Sex Ratio Test
#> 
#> Expected proportion male = 0.4988
#> Observed proportion male = 0.4914
#> X-squared = 1.8713, p = 0.1713
#> 
```
