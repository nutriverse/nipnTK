################################################################################
#
#' Skew and kurtosis
#'
#' @param x Numeric vector
#'
#' @returns A list of class "skewKurt" with:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *s* | Skewness with direction |
#' | *s.se* | Standard error of skewness|
#' | *s.z* | Test statistic (`s.z = s / s.se`) |
#' | *s.p* | `p-value` (`s != 0`) |
#' | *k* | Excess kurtosis with direction |
#' | *k.se* | Standard error of excess kurtosis |
#' | *k.z* | Test statistic (`k.z = k / k.se`) |
#' | *k.p* | `p-value` (`k != 0`) |
#'
#' @examples
#' # Use skewKurt() on an anthropometric data from a SMART survey in
#' # Kabul, Afghanistan (dist.ex01)
#' svy <- dist.ex01
#' skewKurt(svy$muac)
#'
#' @export
#'
#
################################################################################

skewKurt <- function(x) {
  x <- x[!is.na(x)]
  n <- length(x)
  x <- x - mean(x)
  s <- sqrt(n) * sum(x^3) / (sum(x^2)^(3/2))
  s.se <- sqrt((6 * n * (n - 1)) / ((n - 2) * (n + 1) * (n + 3)))
  s.z <- s / s.se
  s.p <- 2 * stats::pnorm(abs(s.z), lower.tail = FALSE)
  k <- (n * sum(x^4)/(sum(x^2)^2)) - 3
  k.se <- 2 * s.se * sqrt((n^2 - 1) / ((n - 3) * (n + 5)))
  k.z <- k / k.se
  k.p <- 2 * stats::pnorm(abs(k.z), lower.tail = FALSE)
  result <- list(s = s, s.se = s.se, s.z = s.z, s.p = s.p,
                 k = k, k.se = k.se, k.z = k.z, k.p = k.p)
  class(result) <- "skewKurt"
  return(result)
}


################################################################################
#
#' [print()] helper function for [skewKurt()] function
#'
#' @param x Object resulting from applying the [skewKurt()] function
#' @param ... Additional [print()] parameters
#'
#' @returns Printed output of [skewKurt()] function
#'
#' @examples
#' # Use skewKurt() on an anthropometric data from a SMART survey in
#' # Kabul, Afghanistan (dist.ex01)
#' svy <- dist.ex01
#' sk <- skewKurt(svy$muac)
#' print(sk)
#'
#' @export
#'
#
################################################################################

print.skewKurt <- function(x, ...) {
  cat("\n\tSkewness and kurtosis\n\n", sep = "")
  cat("Skewness = ", formatC(x$s, format = "f", flag = "+", width = 6),
      "\tSE = ", formatC(x$s.se, format = "f", width = 6), "\tz = ",
      formatC(abs(x$s.z), format = "f", width = 6), "\tp = ",
      formatC(x$s.p, format = "f", width = 6), "\n", sep = "")
  cat("Kurtosis = ", formatC(x$k, format = "f", flag = "+", width = 6),
      "\tSE = ", formatC(x$k.se, format = "f", width = 6), "\tz = ",
      formatC(abs(x$k.z), format = "f", width = 6), "\tp = ",
      formatC(x$k.p, format = "f", width = 6), "\n\n", sep = "")
}
