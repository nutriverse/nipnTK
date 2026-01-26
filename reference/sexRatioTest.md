# Sex Ratio Test

Sex Ratio Test

## Usage

``` r
sexRatioTest(sex, codes = c(1, 2), pop = c(1, 1))
```

## Arguments

- sex:

  A vector of values that indicate sex

- codes:

  Codes used to identify males and females (in that order)

- pop:

  Relative populations of males and females (in that order)

## Value

A list of class `"sexRatioTest"` with:

|              |                                         |
|--------------|-----------------------------------------|
| **Variable** | **Description**                         |
| *pM*         | Observed proportion male                |
| *eM*         | Expected proportion male                |
| *X2*         | Chi-squared test statistic              |
| *df*         | Degrees of freedom for Chi-squared test |
| *p*          | `p-value` for Chi-squared test          |

## Examples

``` r
# Use sexRatioTest() on household roster data from a survey in Tanzania
# (as.ex01) and census data of Tanzania extracted from Wolfram|Alpha knowledge
# engine (as.ex02)
svy <- as.ex01
ref <- as.ex02
censusM <- sum(ref$Males)
censusF <- sum(ref$Females)
sexRatioTest(svy$sex, codes = c(1, 2), pop = c(censusM, censusF))
#> 
#>  Sex Ratio Test
#> 
#> Expected proportion male = 0.4988
#> Observed proportion male = 0.4914
#> X-squared = 1.8713, p = 0.1713
#> 
```
