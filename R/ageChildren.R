################################################################################
#
#' Goodness of fit to an expected model-based age distribution
#'
#' A simple model-based method for calculating expected numbers using
#' exponential decay in a population in which births and deaths balance each
#' other and with a 1:1 male to female sex ratio. This function is built
#' specifically to test goodness of fit for a sample of children aged 6-59
#' months old grouped into four 1 year age groups and 1 half year age group
#' (6 to less than 18 months, 18 to less than 30 months, 30 to less than 42
#' months, 42 to less than 54 months, and 54 months to less than 60 months).
#'
#' @param age A vector of ages. Should either be in whole months (integer) or in
#'   calculated decimal months (numeric).
#' @param u5mr A numeric value for under five years mortality rate expressed as
#'   deaths / 10,000 persons / day. Default is set to 1.
#'
#' @returns A list of class "ageChildren" with:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *u5mr* | Under five years mortality rate as deaths / 10000 persons / day |
#' | *observed* | Table of counts in each (year-centred) age group |
#' | *expected* | Table of expected counts in each (year-centred) age group |
#' | *X2* | Chi-squared test statistic |
#' | *df* | Degrees of freedom for Chi-squared test |
#' | *p* | p-value for Chi-squared test |
#'
#' @examples
#' # Chi-Squared test for age of children in dp.ex02 sample dataset using an
#' # u5mr of 1 / 10,000 / day.
#' svy <- dp.ex02
#' ac <- ageChildren(svy$age, u5mr = 1)
#' ac
#'
#' # Apply function to each sex separately
#' # Males
#' acM <- ageChildren(svy$age[svy$sex == 1], u5mr = 1)
#' acM
#' # Females
#' acF <- ageChildren(svy$age[svy$sex == 2], u5mr = 1)
#'
#' # Simplified call to function by sex
#' by(svy$age, svy$sex, ageChildren, u5mr = 1)
#'
#' @export
#'
#
################################################################################

ageChildren <- function(age,
                        u5mr = 1) {
  ## If age is numeric ----
  if (is.numeric(age)) age <- floor(age)

  ## If x is not numeric or integer ----
  if (!is.numeric(age) & !is.integer(age))
    stop("Age should be of class integer or numeric. Try again.")

  ## Check that u5mr is numeric ----
  if (!is.numeric(u5mr))
    stop ("Under-5 mortality rate should be numeric. Try again.")

  ## Create breaks ----
  breaks <- c(6, 18, 30, 42, 54, 60)

  ## Create age groupings based on breaks ----
  ycag <- cut(
    age, breaks = breaks, labels = seq_len(length(breaks) - 1),
    include.lowest = TRUE, right = FALSE,
  )

  ## Model the age distribution ----
  z <- (u5mr / 10000) * 365.25
  t <- seq(from = 0, to = length(breaks) - 2, by = 1)
  p <- exp(-z * t)
  d <- c(1, 1, 1, 1, 0.5)
  p <- d * p / sum(d * p)
  expected <- p * sum(table(ycag))
  names(expected) <- seq_len(length(breaks) - 1)
  observed <- fullTable(ycag, values = seq_len(length(breaks) - 1))
  X2 <- sum((observed - expected) ^ 2 / expected)
  pX2 <- stats::pchisq(X2, df = length(breaks) - 2, lower.tail = FALSE)
  result <- list(u5mr = u5mr,
                 observed = observed,
                 expected = expected,
                 X2 = X2,
                 df = length(breaks) - 2,
                 p = pX2)
  class(result) <- "ageChildren"
  
  result
}


################################################################################
#
#' [print()] helper function for [ageChildren()] function
#'
#' @param x Object resulting from applying [ageChildren()] function
#' @param ... Additional [print()] arguments
#'
#' @returns Printed output of [ageChildren()] function
#'
#' @examples
#' # Print Chi-Squared test for age of children in dp.ex02 sample dataset using
#' # an u5mr of 1 / 10,000 / day.
#' svy <- dp.ex02
#' ac <- ageChildren(svy$age, u5mr = 1)
#' print(ac)
#'
#' @export
#'
#
################################################################################

print.ageChildren <- function(x, ...) {
  cat("\n\tAge Test (Children)\n\n", sep = "")
  cat("X-squared = ",
      formatC(x$X2, format = "f", width = 6),
      ", df = ", x$df, ", p = ",
      formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
}


################################################################################
#
#' Plot helper function for [ageChildren()] function
#'
#' @param x Object resulting from applying [ageChildren()] function
#' @param ... Additional [barplot()] graphical parameters
#'
#' @returns Bar plot comparing table of observed counts vs table of expected
#'   counts
#'
#' @examples
#' # Plot Chi-Squared test for age of children in dp.ex02 sample dataset using
#' # an u5mr of 1 / 10,000 / day.
#' svy <- dp.ex02
#' ac <- ageChildren(svy$age, u5mr = 1)
#' plot(ac)
#'
#' @export
#'
#
################################################################################

plot.ageChildren <- function(x, ...) {
  YLIM = c(0, max(max(x$observed), max(x$expected)))
  withr::local_par(mfcol = c(1, 2))
  graphics::barplot(x$observed, main = "Observed", ylim = YLIM)
  graphics::barplot(x$expected, main = "Expected", ylim = YLIM)
}
