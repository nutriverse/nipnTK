################################################################################
#
#' ageChildren
#'
#' Goodness of fit to an expected (model-based) age distribution
#'
#' @param age Vector of ages
#' @param u4mr Under five years mortality rate as deaths / 10,000 persons / day
#' @return A list of class "ageChildren" with:
#'     \describe{
#'       \item{\code{u5mr}}{Under five years mortality rate as deaths / 10000 persons / day}
#'       \item{\code{observed}}{Table of counts in each (year-centred) age group}
#'       \item{\code{expected}}{Table of expected counts in each (year-centred) age group}
#'       \item{\code{X2}}{Chi-squared test statistic}
#'       \item{\code{df}}{Degrees of freedom for Chi-squared test}
#'       \item{\code{p}}{p-value for Chi-squared test}
#'     }
#' @examples
#'     #
#'
#'
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
