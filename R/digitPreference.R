################################################################################
#
#' Digit preference test
#'
#' Digit preference is the observation that the final number in a measurement
#' occurs with a greater frequency that is expected by chance. This can occur
#' because of rounding, the practice of increasing or decreasing the value in a
#' measurement to the nearest whole or half unit, or because data are made up.
#' The [digitPreference()] function assesses the level by which digit
#' preference exists in a given dataset using a `digit preference score
#' (DPS)`.
#'
#' DPS definition from:
#'
#' \cite{Kari Kuulasmaa K, Hense HW, Tolonen H (for the WHO MONICA Project),
#' Quality Assessment of Data on Blood Pressure in the WHO MONICA Project,
#' WHO MONICA Project e-publications No. 9, WHO, Geneva, May 1998 available
#' from \url{https://www.thl.fi/publications/monica/bp/bpqa.htm}}
#'
#' @param x Numeric vector of measurements
#' @param digits Number of decimal places in `x`. Using `digits = 1`
#'   (e.g.) allows 105 to be treated as 105.0
#' @param values A vector of possible values for the final digit (default = 0:9)
#'
#' @returns A list of class `"digitPreference"` with:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *dps* | Digit Preference Score (DPS) |
#' | *tab* | Table of final digit counts |
#' | *pct* | Table of proportions (\\%) of final digit counts |
#'
#' @examples
#' # Digit preference test applied to anthropometric data from a single state
#' # from a DHS survey in a West African country
#' svy <- dp.ex01
#' digitPreference(svy$wt, digits = 1)
#'
#' @export
#'
#
################################################################################

digitPreference <- function(x, digits = 1, values = 0:9) {
  dataName <- deparse(substitute(x))
  x <- formatC(x, digits = digits, format = "f")
  finalDigit <- substr(x, nchar(x), nchar(x))
  tab <- fullTable(finalDigit, values = values)
  names(dimnames(tab)) <- dataName
  chiSq <- stats::chisq.test(tab)
  pct <- round(prop.table(tab) * 100, 1)
  dps <- round(
    100 * sqrt(chiSq$statistic / (sum(chiSq$observed) * chiSq$parameter)), 2
  )
  dpsClass <- ifelse(dps < 8, "Excellent",
                ifelse(dps < 12, "Good",
                  ifelse(dps < 20, "Acceptable", "Problematic")))
  names(dpsClass) <- "SMART DPS Class"
  names(dps) <- NULL
  result <- list(dps = dps, tab = tab, pct = pct, dpsClass = dpsClass)
  class(result) <- "digitPreference"
  
  result
}


################################################################################
#
#' [print()] helper function for [digitPreference()] function
#'
#' @param x Object resulting from applying the [digitPreference()] function.
#' @param ... Additional [print()] parameters
#'
#' @returns Printed output of [digitPreference()] function
#'
#' @examples
#' # Print output of digit preference test applied to anthropometric data from a
#' #single state from a DHS survey in a West African country
#' svy <- dp.ex01
#' print(digitPreference(svy$wt, digits = 1))
#'
#' @export
#'
#
################################################################################

print.digitPreference <- function(x, ...) {
  cat("\n\tDigit Preference Score\n\n", sep = "")
  cat("data:\t", names(dimnames(x$tab)), "\n", sep = "")
  cat("Digit Preference Score (DPS) = ", x$dps,
      " (", x$dpsClass, ")\n\n", sep = "")
}


################################################################################
#
#' [plot()] helper function for [digitPreference()] function
#'
#' @param x Object resulting from applying the [digitPreference()] function.
#' @param main Title of plot
#' @param xlab `x-axis` label; default is "Final Digit"
#' @param ylab `y-axis` label; default is "Frequency"
#' @param cex Character expansion; default is 0.75
#' @param ... Additional [plot()] parameters
#'
#' @returns Plotted output of [digitPreference()] function comparing the
#' frequencies of the various final digits
#'
#' @examples
#' # Plot output of digit preference test applied to anthropometric data from a
#' # single state from a DHS survey in a West African country
#' svy <- dp.ex01
#' digitPreference(svy$wt, digits = 1)
#' plot(digitPreference(svy$wt, digits = 1))
#'
#' @export
#'
#
################################################################################

plot.digitPreference <- function(x,
                                 main = "",
                                 xlab = "Final Digit",
                                 ylab = "Frequency",
                                 cex = 0.75,
                                 ...) {
  main <- ifelse(main == "", names(dimnames(x$tab)), main)
  main <- paste(main, " (DPS = ", x$dps, " : ", x$dpsClass, ")", sep = "")
  plot(x$tab, main = main, xlab = xlab, ylab = ylab, frame.plot = FALSE, lwd = 3)
  graphics::abline(h = sum(x$tab) / length(x$tab), lty = 3)
  boxText(as.numeric(names(x$tab)), rep(max(x$tab) * 0.2, length(x$tab)),
          paste(sprintf(fmt = "%3.1f", x$pct), "%", sep = ""),
          cex = cex, pad = FALSE)
  boxText(sum(par("usr")[1:2]) / 2, max(x$tab) * 0.1,
          "(numbers on bars represent the proportions in each class)",
          cex = cex, pad = TRUE)
}
