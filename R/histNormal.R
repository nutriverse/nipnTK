################################################################################
#
#' Histogram with normal curve superimposed to help with “by-eye” assessments
#' of normality of distribution
#'
#' @param x A numeric vector
#' @param xlab `x-axis` label
#' @param ylab `y-axis` label
#' @param main Plot title
#' @param breaks Passed to [hist()] function (`?hist` for details)
#' @param ylim `y-axis` limits
#'
#' @return NULL
#'
#' @examples
#' # histNormal() with data from a SMART survey in Kabul, Afghanistan
#' # (dist.ex01)
#' svy <- dist.ex01
#' histNormal(svy$muac)
#' histNormal(svy$haz)
#' histNormal(svy$waz)
#' histNormal(svy$whz)
#'
#' @export
#'
#
################################################################################

histNormal <- function(x,
                       xlab = deparse(substitute(x)),
                       ylab = "Frequency",
                       main = deparse(substitute(x)),
                       breaks = "Sturges",
                       ylim = NULL) {
  h <- graphics::hist(x, plot = FALSE, breaks = breaks)
  xfit <- seq(min(x, na.rm = TRUE), max(x, na.rm = TRUE), length = 100)
  yfit <- stats::dnorm(xfit,
                       mean = mean(x, na.rm = TRUE),
                       sd = stats::sd(x, na.rm = TRUE))
  yfit <- yfit * diff(h$mids[1:2]) * length(x)

  if(is.null(ylim)) {
    ylim <- c(0, max(max(h$counts), max(yfit)))
  }

  hist(x, xlab = xlab, ylab = ylab, main = main, breaks = breaks, ylim = ylim)
  lines(xfit, yfit, lty = 3)
}
