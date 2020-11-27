################################################################################
#
#' Age ratio test
#'
#' Age Ratio Test is an age-related test of survey and data quality.
#'
#' @param x Numeric vector (age)
#' @param ratio Expected age ratio
#'
#' @return A lit of class `"ageRatioTest"` with:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *expectedR* | Expected sex ratio |
#' | *expectedP* | Expected proportion aged 6:29 months |
#' | *observedR* | Observed sex ratio |
#' | *observedP* | Observed proportion aged 6:29 months |
#' | *X2* | Chi-squared test statistic |
#' | *df* | Degrees of freedom for Chi-squared test |
#' | *p* | `p-value` for Chi-squared test |
#'
#' @examples
#' # Age-ratio test on survey dataset from Kabul, Afghanistan (dp.ex02)
#' # with an age ratio of 0.85
#' svy <- dp.ex02
#' ageRatioTest(svy$age, ratio = 0.85)
#'
#' # The age ratio test applied to data for each sex separately
#' by(svy$age, svy$sex, ageRatioTest, ratio = 0.85)
#'
#' @export
#'
#
################################################################################

ageRatioTest <- function(x, ratio = 0.85) {
  g <- recode(x, "6:29=1; 30:59=2")
  expectedP <- ratio / (ratio + 1)
  observedP <- sum(g == 1)/ sum(table(g))
  observedR <- observedP / (1 - observedP)
  X2 <- prop.test(sum(g == 1), sum(table(g)), p = expectedP)
  result <- list(expectedR = ratio,
                 expectedP = expectedP,
                 observedR = observedR,
                 observedP = observedP,
                 X2 = X2$statistic,
                 df = X2$parameter,
                 p = X2$p.value)
  class(result) <- "ageRatioTest"
  return(result)
}


################################################################################
#
#' [print()] helper function for [ageRatioTest()] function
#'
#' @param x Object resulting from applying [ageRatioTest()] function
#' @param ... Additional [print()] arguments
#'
#' @return Printed output of [ageRatioTest()] function
#'
#' @examples
#' # Print age-ratio test results for survey dataset from Kabul, Afghanistan (dp.ex02)
#' svy <- dp.ex02
#' print(ageRatioTest(svy$age, ratio = 0.85))
#'
#' @export
#'
#
################################################################################

print.ageRatioTest <- function(x, ...) {
  cat("\n\t\tAge Ratio Test (children\'s data)\n\n", sep = "")
  cat("                    Expected age ratio = ",
      formatC(x$expectedR, format = "f", width = 6), "\n", sep = "")
  cat("Expected proportion aged 6 - 29 months = ",
      formatC(x$expectedP, format = "f", width = 6), "\n\n", sep = "")
  cat("                    Observed age ratio = ",
      formatC(x$observedR, format = "f", width = 6), "\n", sep = "")
  cat("Observed proportion aged 6 - 29 months = ",
      formatC(x$observedP, format = "f", width = 6), "\n\n", sep = "")
  cat("X-squared = ", formatC(x$X2, format = "f", width = 6),
      ", p = ", formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
}
