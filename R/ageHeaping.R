################################################################################
#
#' Age-heaping analysis
#'
#' Age heaping is the tendency to report children's ages to the nearest year or
#' adults’ ages to the nearest multiple of five or ten years. Age heaping is
#' very common. This is a major reason why data from nutritional anthropometry
#' surveys is often analysed and reported using broad age groups.
#'
#' @param x Vector of ages
#' @param divisor Divisor (usually 5, 6, 10, or 12); default is 12
#'
#' @return A list of class "ageHeaping" with:
#' \describe{
#'   \item{\code{X2}}{Chi-squared test statistic}
#'   \item{\code{df}}{Degrees of freedom or Chi-squared test}
#'   \item{\code{p}}{\code{p-value} for Chi-squared test}
#'   \item{\code{tab}}{Table of remainders (for \code{x \%\%} divisor)}
#'   \item{\code{pct}}{Table of proportions (\code{\%}) of remainders
#'     (for \code{x \%\%} divisor)}
#' }
#'
#' @examples
#' # Test for age heaping using SMART survey data in Kabul, Afghanistan (dp.ex02)
#' # using a divisor of 12
#' svy <- dp.ex02
#' ah12 <- ageHeaping(svy$age)
#' ah12
#'
#' # Test for age heaping using SMART survey data in Kabul, Afthanistan (dp.ex02)
#' # using a divisor of 6
#' ah6 <- ageHeaping(svy$age, divisor = 6)
#' ah6
#'
#' @export
#'
#
################################################################################

ageHeaping <- function(x, divisor = 12) {
  dataName <- deparse(substitute(x))
  r <- x %% divisor
  tab <- fullTable(r, values = 0:(divisor - 1))
  names(dimnames(tab)) <- paste("Remainder of ", dataName, " / ", divisor, sep = "")
  chiSq <- stats::chisq.test(tab)
  pct <- round(prop.table(tab) * 100, 1)
  result <- list(X2 = chiSq$statistic, df = chiSq$parameter, p = chiSq$p.value, tab = tab, pct = pct)
  class(result) <- "ageHeaping"
  return(result)
}


################################################################################
#
#' \code{print} helper functions for \code{ageHeaping} functions
#'
#' @param x Object resulting from applying the \code{\link{ageHeaping}} function
#' @param ... Additional \code{\link{print}} arguments
#'
#' @return Printed output of the \code{\link{ageHeaping}} function
#'
#' @examples
#' # Print age heaping test on SMART survey data in Kabul, Afghanistan (dp.ex02)
#' # using a divisor of 12
#' svy <- dp.ex02
#' ah12 <- ageHeaping(svy$age)
#' print(ah12)
#'
#' @export
#'
#
################################################################################

print.ageHeaping <- function(x, ...) {
  cat("\n\tAge-heaping Analysis\n\n", sep = "")
  cat("data:\t", names(dimnames(x$tab)), "\n", sep = "")
  cat("X-squared = ", x$X2, ", df = ", x$df, ", p-value = ", formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
}


################################################################################
#
#' \code{plot} helper functions for \code{ageHeaping} functions
#'
#' @param x Object resulting from applying the \code{\link{ageHeaping}} function
#' @param main Title of plot
#' @param xlab \code{x-axis} label; default is \code{Remainder}
#' @param ylab \code{y-axis} label; default is \code{Frequency}
#' @param cex Character expansion (numeric); default is 0.75
#' @param ... Additional \code{\link{plot}} graphical parameters
#'
#' @return Barplot of frequency of remainders of age when divided by a specified
#' divisor
#'
#' @examples
#' # Plot age heaping test results on SMART survey data in Kabul, Afghanistan
#' # (dp.ex02) using a divisor of 12
#' svy <- dp.ex02
#' ah12 <- ageHeaping(svy$age)
#' plot(ah12)
#'
#' @export
#'
#
################################################################################

plot.ageHeaping <- function(x,
                            main = "",
                            xlab = "Remainder",
                            ylab = "Frequency",
                            cex = 0.75,
                            ...) {
  main <- ifelse(main == "", names(dimnames(x$tab)), main)
  plot(x$tab,
       main = main,
       xlab = xlab,
       ylab = ylab,
       frame.plot = FALSE,
       lwd = 3)
  graphics::abline(h = sum(x$tab) / length(x$tab), lty = 3)
  boxText(as.numeric(names(x$tab)),
          rep(max(x$tab) * 0.1, length(x$tab)),
          paste(sprintf(fmt = "%3.1f", x$pct), "%", sep = ""),
          cex = cex, pad = FALSE)
}
