################################################################################
#
#' IQR to detect univariate outliers
#'
#' @param x Numeric vector
#' @param fence \code{IQR} multiplier (defaults to 1.5)
#' @return A logical vector (\code{TRUE} for an outlier)
#' @examples
#' # Use \code{outliersUV()} to detect univariate outliers in an anthropometric
#' # dataset from a SMART survey from Angola (rl.ex01)
#' svy <- rl.ex01
#' svy[outliersUV(svy$muac), ]
#' @export
#'
#
################################################################################

outliersUV <- function(x, fence = 1.5) {
  x <- x[!is.na(x)]
  iqr <- IQR(x)
  quartiles <- quantile(x, probs = c(0.25, 0.75))
  cat("\nUnivariate outliers : Lower fence = ", quartiles[1] - fence * iqr, ", Upper fence = ", quartiles[2] + fence * iqr, "\n\n", sep = "")
  outliers <- (x < quartiles[1] - fence * iqr) | (x > quartiles[2] + fence * iqr)
  return(outliers)
}
