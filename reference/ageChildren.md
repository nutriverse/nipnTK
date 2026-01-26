# Goodness of fit to an expected model-based age distribution

A simple model-based method for calculating expected numbers using
exponential decay in a population in which births and deaths balance
each other and with a 1:1 male to female sex ratio. This function is
built specifically to test goodness of fit for a sample of children aged
6-59 months old grouped into four 1 year age groups and 1 half year age
group (6 to less than 18 months, 18 to less than 30 months, 30 to less
than 42 months, 42 to less than 54 months, and 54 months to less than 60
months).

## Usage

``` r
ageChildren(age, u5mr = 1)
```

## Arguments

- age:

  A vector of ages. Should either be in whole months (integer) or in
  calculated decimal months (numeric).

- u5mr:

  A numeric value for under five years mortality rate expressed as
  deaths / 10,000 persons / day. Default is set to 1.

## Value

A list of class "ageChildren" with:

|              |                                                                 |
|--------------|-----------------------------------------------------------------|
| **Variable** | **Description**                                                 |
| *u5mr*       | Under five years mortality rate as deaths / 10000 persons / day |
| *observed*   | Table of counts in each (year-centred) age group                |
| *expected*   | Table of expected counts in each (year-centred) age group       |
| *X2*         | Chi-squared test statistic                                      |
| *df*         | Degrees of freedom for Chi-squared test                         |
| *p*          | p-value for Chi-squared test                                    |

## Examples

``` r
# Chi-Squared test for age of children in dp.ex02 sample dataset using an
# u5mr of 1 / 10,000 / day.
svy <- dp.ex02
ac <- ageChildren(svy$age, u5mr = 1)
ac
#> 
#>  Age Test (Children)
#> 
#> X-squared = 21.4366, df = 4, p = 0.0003
#> 

# Apply function to each sex separately
# Males
acM <- ageChildren(svy$age[svy$sex == 1], u5mr = 1)
acM
#> 
#>  Age Test (Children)
#> 
#> X-squared = 15.8496, df = 4, p = 0.0032
#> 
# Females
acF <- ageChildren(svy$age[svy$sex == 2], u5mr = 1)

# Simplified call to function by sex
by(svy$age, svy$sex, ageChildren, u5mr = 1)
#> svy$sex: 1
#> 
#>  Age Test (Children)
#> 
#> X-squared = 15.8496, df = 4, p = 0.0032
#> 
#> ------------------------------------------------------------ 
#> svy$sex: 2
#> 
#>  Age Test (Children)
#> 
#> X-squared = 6.8429, df = 4, p = 0.1444
#> 
```
