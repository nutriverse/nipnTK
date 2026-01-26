# Green's Index of Dispersion

Implementation of the Green's Index of Dispersion by bootstrap. The
sampling distribution of the Green's Index is not well described hence
bootstrapping is used to test whether the distribution of cases across
primary sampling units is random.

## Usage

``` r
greensIndex(data, psu, case, replicates = 999)
```

## Arguments

- data:

  Survey dataset (as an R data.frame)

- psu:

  Name of variable holding PSU (cluster) data as a character vector of
  length = 1 (e.g. `psu`)

- case:

  Name of variable holding case status as a character vector of length =
  1 (e.g. *GAM*). The function assumes that case status is coded with 1
  = case

- replicates:

  Number of bootstrap replicates (default is 9999)

## Value

A list of class `GI` with names:

|              |                                                            |
|--------------|------------------------------------------------------------|
| **Variable** | **Description**                                            |
| *GI*         | Estimate of Green's index                                  |
| *LCL*        | 95\\ LCL for GI                                            |
| *UCL*        | 95\\ UCL for GI                                            |
| *minGI*      | Minimum possible GI (maximum uniformity) for the data      |
| *p*          | `p-value` (H0: = Random distribution of cases across PSUs) |

## Details

The value of Green's Index can range between `-1/(n - 1)` for maximum
uniformity (specific to the dataset) and one for maximum clumping. The
interpretation of Green’s Index is straightforward:

|                                |                                         |
|--------------------------------|-----------------------------------------|
| **Green's Index Value**        | **Interpretation**                      |
| *Green's Index close to 0*     | Random                                  |
| *Green's Index greater than 0* | Clumped (i.e. more clumped than random) |
| *Green’s Index less than 0*    | Uniform (i.e. more uniform than random) |

## Examples

``` r
# Apply Green's Index using anthropometric data from a SMART survey in Sudan
# (flag.ex01)
svy <- flag.ex01
svy$flag <- 0
svy$flag <- ifelse(!is.na(svy$haz) & (svy$haz < -6 | svy$haz > 6),
                   svy$flag + 1, svy$flag)
svy$flag <- ifelse(!is.na(svy$whz) & (svy$whz < -5 | svy$whz > 5),
                   svy$flag + 2, svy$flag)
svy$flag <- ifelse(!is.na(svy$waz) & (svy$waz < -6 | svy$waz > 5),
                   svy$flag + 4, svy$flag)
svy <- svy[svy$flag == 0, ]
svy$stunted <- ifelse(svy$haz < -2, 1, 2)

## set seed to 0 to replicate results
set.seed(0)
greensIndex(data = svy, psu = "psu", case = "stunted")
#> 
#>  Green's Index of Dispersion
#> 
#> Green's Index (GI) of Dispersion  = -0.0014, 95% CI = (-0.0021, -0.0005)
#> Maximum uniformity for this data  = -0.0035
#>                          p-value  =  0.0030
#> 
```
