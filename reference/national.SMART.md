# Add SMART flags to a stratified sample survey (e.g. MICS, DHS, national SMART)

Add SMART flags to a stratified sample survey (e.g. MICS, DHS, national
SMART)

## Usage

``` r
national.SMART(x, strata, indices = c("haz", "whz", "waz"))
```

## Arguments

- x:

  Survey dataset (as an R data.frame) with indices present

- strata:

  Name of column in `x` that defines the strata

- indices:

  Names of columns in `x` containing indices

## Value

A data.frame with same structure as `x` with a `flagSMART` column added.
This column is coded using sums of powers of two

## Examples

``` r
# Use the national.SMART() function to flag indices from a national
# SMART survey in Nigeria (flag.ex03)
svy <- flag.ex03
svyFlagged <- national.SMART(x = svy, strata = "state")

# Exclude records with flagging codes relevant to whz:
svyFlagged <- svyFlagged[!(svyFlagged$flagSMART %in% c(2, 3, 6, 7)), ]
```
