# Plot text in a coloured bounding box.

Plot text in a coloured bounding box.

## Usage

``` r
boxText(
  x,
  y,
  labels,
  cex = 0.75,
  col = "white",
  border = FALSE,
  lwd = 0.5,
  pad = TRUE
)
```

## Arguments

- x, y:

  Co-ordinates of text that is to be plotted

- labels:

  Text to be plotted

- cex:

  Character expansion

- col:

  Background colour

- border:

  Border colour

- lwd:

  Border width

- pad:

  Add padding to (L) and (R) ends of bounding box

## Examples

``` r
## Use of boxtext in the ageHeaping plot function
svy <- dp.ex02
ah12 <- ageHeaping(svy$age)

plot.new()
boxText(x = as.numeric(names(ah12$tab)),
        y = max(ah12$tab) * 0.1,
        labels = paste(sprintf(fmt = "%3.1f", ah12$pct), "%", sep = ""),
        cex = 0.5,
        pad = TRUE)

```
