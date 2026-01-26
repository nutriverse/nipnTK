# Fill out a one-dimensional table to include a specified range of values

Fill out a one-dimensional table to include a specified range of values

## Usage

``` r
fullTable(x, values = min(x, na.rm = TRUE):max(x, na.rm = TRUE))
```

## Arguments

- x:

  A vector to tabulate

- values:

  A vector of values to be included in a table. Default is:
  `min(x, na.rm = TRUE):max(x, na.rm = TRUE)`

## Value

A table object including zero cells

## Examples

``` r
# Generate some artificial data and then apply `fullTable()`
set.seed(0)
finalDigits <- sample(x = 0:9, size = 1000, replace = TRUE)
fullTable(finalDigits)
#>   0   1   2   3   4   5   6   7   8   9 
#>  95  80  96 102 106  98 109  95 109 110 
```
