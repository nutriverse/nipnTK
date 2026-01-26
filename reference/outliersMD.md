# Mahalanobis distance to detect bivariate outliers

Mahalanobis distance to detect bivariate outliers

## Usage

``` r
outliersMD(x, y, alpha = 0.001)
```

## Arguments

- x:

  Numeric vector

- y:

  Numeric vector

- alpha:

  Critical `alpha` value to detect an outlier (defaults to 0.001)

## Value

A logical vector (TRUE for an outlier at `p < alpha`)

## Examples

``` r
# Use outliersMD() to detect outliers in an anthropometric data from
# a SMART survey from the Democratic Republic of Congo (sp.ex01)
svy <- sp.ex01
svy[outliersMD(svy$height,svy$weight), ]
#>    age sex weight height muac oedema
#> 1   54   1   20.5  111.5  180      2
#> 6   48   2   18.6   95.3  171      1
#> 16  30   1   16.9   92.5  188      2
#> 62  55   1   15.1  118.0  156      2
#> 66  56   1   15.0  115.0  148      2
```
