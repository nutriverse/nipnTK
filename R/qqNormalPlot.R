################################################################################
#
#' Normal quantile-quantile plot
#'
#' @param x A numeric vector
#'
#' @return NULL
#'
#' @examples
#' # qqNormalPlot() with data from a SMART survey in Kabul, Afghanistan
#' # (dist.ex01)
#' svy <- dist.ex01
#' qqNormalPlot(svy$muac)
#' qqNormalPlot(svy$haz)
#' qqNormalPlot(svy$waz)
#' qqNormalPlot(svy$whz)
#'
#' @export
#'
#
################################################################################

qqNormalPlot <- function(x) {
  main = paste("Normal Q-Q plot for ", deparse(substitute(x)), sep = "")
  stats::qqnorm(x, main = main,
                xlab = "Expected", ylab = "Observed",
                frame.plot = FALSE)
  stats::qqline(x)
}
