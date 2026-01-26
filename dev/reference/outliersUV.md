# IQR to detect univariate outliers

IQR to detect univariate outliers

## Usage

``` r
outliersUV(x, fence = 1.5)
```

## Arguments

- x:

  Numeric vector

- fence:

  `IQR` multiplier (defaults to 1.5)

## Value

A logical vector (TRUE for an outlier)

## Examples

``` r
# Use outliersUV() to detect univariate outliers in an anthropometric
# dataset from a SMART survey from Angola (rl.ex01)
svy <- rl.ex01
svy[outliersUV(svy$muac), ]
#> 
#> Univariate outliers : Lower fence = 98, Upper fence = 178
#> 
#>     age sex weight height  muac oedema
#> 33   24   1    9.8   74.5 180.0      2
#> 93   12   2    6.7   67.0  96.0      1
#> 126  16   2    9.0   74.6 999.0      2
#> 135  18   2    8.5   74.5 999.0      2
#> 194  24   M    7.0   75.0  95.0      2
#> 227   8   M    6.2   66.0  11.1      2
#> 253  35   2    7.6   75.6  97.0      2
#> 381  24   1   10.8   82.8  12.4      2
#> 501  36   2   15.5   93.4 185.0      2
#> 594  21   2    9.8   76.5  13.2      2
#> 714  59   2   18.9   98.5 180.0      2
#> 752  48   2   15.6  102.2 999.0      2
#> 756  59   1   19.4  101.1 180.0      2
#> 873  59   1   20.6  109.4 179.0      2
```
