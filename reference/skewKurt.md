# Skew and kurtosis

Skew and kurtosis

## Usage

``` r
skewKurt(x)
```

## Arguments

- x:

  Numeric vector

## Value

A list of class "skewKurt" with:

|              |                                   |
|--------------|-----------------------------------|
| **Variable** | **Description**                   |
| *s*          | Skewness with direction           |
| *s.se*       | Standard error of skewness        |
| *s.z*        | Test statistic (`s.z = s / s.se`) |
| *s.p*        | `p-value` (`s != 0`)              |
| *k*          | Excess kurtosis with direction    |
| *k.se*       | Standard error of excess kurtosis |
| *k.z*        | Test statistic (`k.z = k / k.se`) |
| *k.p*        | `p-value` (`k != 0`)              |

## Examples

``` r
# Use skewKurt() on an anthropometric data from a SMART survey in
# Kabul, Afghanistan (dist.ex01)
svy <- dist.ex01
skewKurt(svy$muac)
#> 
#>  Skewness and kurtosis
#> 
#> Skewness = +0.0525   SE = 0.0828 z = 0.6348  p = 0.5256
#> Kurtosis = -0.2412   SE = 0.1653 z = 1.4586  p = 0.1447
#> 
```
