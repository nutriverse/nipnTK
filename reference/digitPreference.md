# Digit preference test

Digit preference is the observation that the final number in a
measurement occurs with a greater frequency that is expected by chance.
This can occur because of rounding, the practice of increasing or
decreasing the value in a measurement to the nearest whole or half unit,
or because data are made up. The `digitPreference()` function assesses
the level by which digit preference exists in a given dataset using a
`digit preference score (DPS)`.

## Usage

``` r
digitPreference(x, digits = 1, values = 0:9)
```

## Arguments

- x:

  Numeric vector of measurements

- digits:

  Number of decimal places in `x`. Using `digits = 1` (e.g.) allows 105
  to be treated as 105.0

- values:

  A vector of possible values for the final digit (default = 0:9)

## Value

A list of class `"digitPreference"` with:

|              |                                                 |
|--------------|-------------------------------------------------|
| **Variable** | **Description**                                 |
| *dps*        | Digit Preference Score (DPS)                    |
| *tab*        | Table of final digit counts                     |
| *pct*        | Table of proportions (\\) of final digit counts |

## Details

DPS definition from:

Kari Kuulasmaa K, Hense HW, Tolonen H (for the WHO MONICA Project),
Quality Assessment of Data on Blood Pressure in the WHO MONICA Project,
WHO MONICA Project e-publications No. 9, WHO, Geneva, May 1998 available
from <https://www.thl.fi/publications/monica/bp/bpqa.htm>

## Examples

``` r
# Digit preference test applied to anthropometric data from a single state
# from a DHS survey in a West African country
svy <- dp.ex01
digitPreference(svy$wt, digits = 1)
#> 
#>  Digit Preference Score
#> 
#> data:    svy$wt
#> Digit Preference Score (DPS) = 11.86 (Good)
#> 
```
