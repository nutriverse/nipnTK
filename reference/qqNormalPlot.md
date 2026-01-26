# Normal quantile-quantile plot

Normal quantile-quantile plot

## Usage

``` r
qqNormalPlot(x)
```

## Arguments

- x:

  A numeric vector

## Examples

``` r
# qqNormalPlot() with data from a SMART survey in Kabul, Afghanistan
# (dist.ex01)
svy <- dist.ex01
qqNormalPlot(svy$muac)

qqNormalPlot(svy$haz)

qqNormalPlot(svy$waz)

qqNormalPlot(svy$whz)

```
