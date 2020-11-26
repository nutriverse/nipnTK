################################################################################
#
#' IQR to detect univariate outliers
#'
#' @param x Numeric vector
#' @param fence `IQR` multiplier (defaults to 1.5)
#'
#' @return A logical vector (TRUE for an outlier)
#'
#' @examples
#' # Use outliersUV() to detect univariate outliers in an anthropometric
#' # dataset from a SMART survey from Angola (rl.ex01)
#' svy <- rl.ex01
#' svy[outliersUV(svy$muac), ]
#'
#' @export
#'
#
################################################################################

outliersUV <- function(x, fence = 1.5) {
  iqr <- stats::IQR(x, na.rm = TRUE)
  quartiles <- stats::quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
  cat("\nUnivariate outliers : Lower fence = ",
      quartiles[1] - fence * iqr,
      ", Upper fence = ", quartiles[2] + fence * iqr, "\n\n", sep = "")
  outliers <- (x < quartiles[1] - fence * iqr) | (x > quartiles[2] + fence * iqr)
  outliers[is.na(outliers)] <- FALSE
  return(outliers)
}
