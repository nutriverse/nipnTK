# Age-heaping analysis

Age heaping is the tendency to report children's ages to the nearest
year or adults’ ages to the nearest multiple of five or ten years. Age
heaping is very common. This is a major reason why data from nutritional
anthropometry surveys is often analysed and reported using broad age
groups.

## Usage

``` r
ageHeaping(x, divisor = 12)
```

## Arguments

- x:

  A vector of ages. Should either be in whole months (integer) or in
  calculated decimal months (numeric).

- divisor:

  Divisor (usually 5, 6, 10, or 12); default is 12

## Value

A list of class "ageHeaping" with:

|              |                                                                 |
|--------------|-----------------------------------------------------------------|
| **Variable** | **Description**                                                 |
| *X2*         | Chi-squared test statistic                                      |
| *df*         | Degrees of freedom or Chi-squared test                          |
| *p*          | `p-value` for Chi-squared test                                  |
| *tab*        | Table of remainders (for `x \%\%` divisor)                      |
| *pct*        | Table of proportions (`\%`) of remainders for `x \%\%` divisor) |

## Examples

``` r
# Test for age heaping using SMART survey data in Kabul, Afghanistan (dp.ex02)
# using a divisor of 12
svy <- dp.ex02
ah12 <- ageHeaping(svy$age)
ah12
#> 
#>  Age-heaping Analysis
#> 
#> data:    Remainder of svy$age / 12
#> X-squared = 214.9588, df = 11, p-value = 0.0000
#> 

# Test for age heaping using SMART survey data in Kabul, Afthanistan (dp.ex02)
# using a divisor of 6
ah6 <- ageHeaping(svy$age, divisor = 6)
ah6
#> 
#>  Age-heaping Analysis
#> 
#> data:    Remainder of svy$age / 6
#> X-squared = 145.0275, df = 5, p-value = 0.0000
#> 
```
