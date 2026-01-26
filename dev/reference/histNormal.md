# Histogram with normal curve superimposed to help with “by-eye” assessments of normality of distribution

Histogram with normal curve superimposed to help with “by-eye”
assessments of normality of distribution

## Usage

``` r
histNormal(
  x,
  xlab = deparse(substitute(x)),
  ylab = "Frequency",
  main = deparse(substitute(x)),
  breaks = "Sturges",
  ylim = NULL
)
```

## Arguments

- x:

  A numeric vector

- xlab:

  `x-axis` label

- ylab:

  `y-axis` label

- main:

  Plot title

- breaks:

  Passed to [`hist()`](https://rdrr.io/r/graphics/hist.html) function
  ([`?hist`](https://rdrr.io/r/graphics/hist.html) for details)

- ylim:

  `y-axis` limits

## Examples

``` r
# histNormal() with data from a SMART survey in Kabul, Afghanistan
# (dist.ex01)
svy <- dist.ex01
histNormal(svy$muac)

histNormal(svy$haz)

histNormal(svy$waz)

histNormal(svy$whz)

```
