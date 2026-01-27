################################################################################
#
#' Age-heaping analysis
#'
#' Age heaping is the tendency to report children's ages to the nearest year or
#' adults’ ages to the nearest multiple of five or ten years. Age heaping is
#' very common. This is a major reason why data from nutritional anthropometry
#' surveys is often analysed and reported using broad age groups.
#'
#' @param x A vector of ages. Should either be in whole months (integer) or in
#'   calculated decimal months (numeric).
#' @param divisor Divisor (usually 5, 6, 10, or 12); default is 12
#'
#' @returns A list of class "ageHeaping" with:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *X2* | Chi-squared test statistic |
#' | *df* | Degrees of freedom or Chi-squared test |
#' | *p* | `p-value` for Chi-squared test |
#' | *tab* | Table of remainders (for `x \%\%` divisor) |
#' | *pct* | Table of proportions (`\%`) of remainders for `x \%\%` divisor) |
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
  ## If x is not numeric or integer ----
  if (!is.numeric(x) & !is.integer(x))
    stop("Age should be of class integer or numeric. Try again.")

  dataName <- deparse(substitute(x))
  r <- x %% divisor
  tab <- fullTable(r, values = 0:(divisor - 1))
  names(dimnames(tab)) <- paste0("Remainder of ", dataName, " / ", divisor)
  chiSq <- stats::chisq.test(tab)
  pct <- round(prop.table(tab) * 100, 1)
  result <- list(X2 = chiSq$statistic, df = chiSq$parameter,
                 p = chiSq$p.value, tab = tab, pct = pct)
  class(result) <- "ageHeaping"
  
  result
}


################################################################################
#
#' [print()] helper functions for [ageHeaping()] functions
#'
#' @param x Object resulting from applying the [ageHeaping()] function
#' @param ... Additional [print()] arguments
#'
#' @returns Printed output of the [ageHeaping()] function
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
  cat("X-squared = ", x$X2, ", df = ", x$df, ", p-value = ",
      formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
}


################################################################################
#
#' [plot()] helper functions for [ageHeaping()] functions
#'
#' @param x Object resulting from applying the [ageHeaping()] function
#' @param main Title of plot
#' @param xlab `x-axis` label; default is `Remainder`
#' @param ylab `y-axis` label; default is `Frequency`
#' @param cex Character expansion (numeric); default is 0.75
#' @param ... Additional [plot()] graphical parameters
#'
#' @returns Barplot of frequency of remainders of age when divided by a specified
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
