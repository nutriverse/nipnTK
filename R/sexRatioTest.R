################################################################################
#
#' Sex Ratio Test
#'
#' @param sex Numeric vector (`sex`)
#' @param codes Codes used to identify males and females (in that order)
#' @param pop Relative populations of males and females (in that order)
#'
#' @return A list of class `"sexRatioTest"` with:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *pM* | Observed proportion male |
#' | *eM* | Expected proportion male |
#' | *X2* | Chi-squared test statistic |
#' | *df* | Degrees of freedom for Chi-squared test |
#' | *p* | `p-value` for Chi-squared test |
#'
#' @examples
#' # Use sexRatioTest() on household roster data from a survey in Tanzania
#' # (as.ex01) and census data of Tanzania extracted from Wolfram|Alpha knowledge
#' # engine (as.ex02)
#' svy <- as.ex01
#' ref <- as.ex02
#' censusM <- sum(ref$Males)
#' censusF <- sum(ref$Females)
#' sexRatioTest(svy$sex, codes = c(1, 2), pop = c(censusM, censusF))
#'
#' @export
#'
#
################################################################################

sexRatioTest <- function(sex, codes = c(1, 2), pop = c(1, 1)) {
  nM <- sum(sex == codes[1], na.rm = TRUE)
  nF <- sum(sex == codes[2], na.rm = TRUE)
  eM <- pop[1] / (pop[1] + pop[2])
  X2 <- stats::prop.test(nM, nM + nF, p = eM)
  result <- list(pM = X2$estimate,
                 eM = eM,
                 X2 = X2$statistic,
                 df = X2$parameter,
                 p = X2$p.value)
  class(result) <- "sexRatioTest"
  return(result)
}


################################################################################
#
#' [print()] helper function for [sexRatioTest()] function
#'
#' @param x Output resulting from applying the [sexRatioTest()] function
#' @param ... Additional [print()] parameters
#'
#' @return Printed output of [sexRatioTest()] function
#'
#' @examples
#' # Use sexRatioTest() on household roster data from a survey in Tanzania
#' # (as.ex01) and census data of Tanzania extracted from Wolfram|Alpha knowledge
#' # engine (as.ex02)
#' svy <- as.ex01
#' ref <- as.ex02
#' censusM <- sum(ref$Males)
#' censusF <- sum(ref$Females)
#' srt <- sexRatioTest(svy$sex, codes = c(1, 2), pop = c(censusM, censusF))
#' print(srt)
#'
#' @export
#'
#
################################################################################

print.sexRatioTest <- function(x, ...) {
  cat("\n\tSex Ratio Test\n\n", sep = "")
  cat("Expected proportion male = ",
      formatC(x$eM, format = "f", width = 6), "\n", sep = "")
  cat("Observed proportion male = ",
      formatC(x$pM, format = "f", width = 6), "\n", sep = "")
  cat("X-squared = ", formatC(x$X2, format = "f", width = 6),
      ", p = ", formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
}
