# Age ratio test

Age ratio test is an age-related test of survey and data quality. In
this test, the ratio of the number of children aged from 6 to 29 months
to the number of children aged from 30 to 59 months is calculated. This
ratio is then compared to an expected ratio (usually set at 0.85). The
difference of the observed ratio to the expected ratio is then compared
statistically using Chi-squared test.

## Usage

``` r
ageRatioTest(x, ratio = 0.85)
```

## Arguments

- x:

  A vector of ages. Should either be in whole months (integer) or in
  calculated decimal months (numeric).

- ratio:

  Expected age ratio. Default is 0.85.

## Value

A lit of class `"ageRatioTest"` with:

|              |                                         |
|--------------|-----------------------------------------|
| **Variable** | **Description**                         |
| *expectedR*  | Expected sex ratio                      |
| *expectedP*  | Expected proportion aged 6:29 months    |
| *observedR*  | Observed sex ratio                      |
| *observedP*  | Observed proportion aged 6:29 months    |
| *X2*         | Chi-squared test statistic              |
| *df*         | Degrees of freedom for Chi-squared test |
| *p*          | `p-value` for Chi-squared test          |

## Examples

``` r
# Age-ratio test on survey dataset from Kabul, Afghanistan (`dp.ex02`)
# with an age ratio of 0.85
svy <- dp.ex02
ageRatioTest(svy$age, ratio = 0.85)
#> 
#>      Age Ratio Test (children's data)
#> 
#>                     Expected age ratio = 0.8500
#> Expected proportion aged 6 - 29 months = 0.4595
#> 
#>                     Observed age ratio = 0.8654
#> Observed proportion aged 6 - 29 months = 0.4639
#> 
#> X-squared = 0.0531, p = 0.8178
#> 

# The age ratio test applied to data for each sex separately
by(svy$age, svy$sex, ageRatioTest, ratio = 0.85)
#> svy$sex: 1
#> 
#>      Age Ratio Test (children's data)
#> 
#>                     Expected age ratio = 0.8500
#> Expected proportion aged 6 - 29 months = 0.4595
#> 
#>                     Observed age ratio = 0.8638
#> Observed proportion aged 6 - 29 months = 0.4635
#> 
#> X-squared = 0.0145, p = 0.9041
#> 
#> ------------------------------------------------------------ 
#> svy$sex: 2
#> 
#>      Age Ratio Test (children's data)
#> 
#>                     Expected age ratio = 0.8500
#> Expected proportion aged 6 - 29 months = 0.4595
#> 
#>                     Observed age ratio = 0.8670
#> Observed proportion aged 6 - 29 months = 0.4644
#> 
#> X-squared = 0.0247, p = 0.8750
#> 
```
