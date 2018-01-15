################################################################################
#
#  Goodness of fit to an expected (model-based) age distribution with print()
#  and plot() helper functions
#
################################################################################
#
#  Parameters :
#
#    age   Vector of ages
#
#    u5mr  Under fives years mortality rate as deaths / 10,000 persons / day
#
################################################################################
#
#  Returns :
#
#    A list of class "ageChildren" with:
#
#      u5mr      Under fives years mortality rate as deaths / 10K persons / day
#
#      observed  Table of counts in each (year-centred) age group
#
#      expected  Table of expected counts in each (year-centred) age group
#
#      X2        Chi-squared test statistic
#
#      df        Degrees of freedom for Chi-squared test
#
#      p         p-value for for Chi-squared test
#
################################################################################

ageChildren <- function(age, u5mr = 0, groups = "6:17=1; 18:29=2; 30:41=3; 42:53=4; 54:59=5")
  {
  ycag <- recode(age, "6:17=1; 18:29=2; 30:41=3; 42:53=4; 54:59=5")
  z <- (u5mr / 10000) * 365.25
  t <- 0:4
  p <- exp(-z * 0:4)
  d <- c(1, 1, 1, 1, 0.5)
  p <- d * p / sum(d * p)
  expected <- p * sum(table(ycag))
  names(expected) <- 1:5
  observed <- fullTable(ycag, values = 1:5)
  X2 <- sum((observed - expected)^2 / expected)
  pX2 <- pchisq(X2, df = 4, lower.tail = FALSE)
  result <- list(u5mr = u5mr, observed = observed, expected = expected, X2 = X2, df = 4, p = pX2)
  class(result) <- "ageChildren"
  return(result)
  }

print.ageChildren <- function(x)
  {
  cat("\n\tAge Test (Children)\n\n", sep = "")
  cat("X-squared = ", formatC(x$X2, format = "f", width = 6), ", df = ", x$df, ", p = ", formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
  }

plot.ageChildren <- function(x)
  {
  YLIM = c(0, max(max(x$observed), max(x$expected)))
  par(mfcol = c(1, 2))
  barplot(x$observed, main = "Observed", ylim = YLIM)
  barplot(x$expected, main = "Expected", ylim = YLIM)
  }
