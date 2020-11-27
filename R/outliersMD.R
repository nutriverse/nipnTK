################################################################################
#
#' Mahalanobis distance to detect bivariate outliers
#'
#' @param x Numeric vector
#' @param y Numeric vector
#' @param alpha Critical `alpha` value to detect and outlier (defaults to
#'     0.001)
#' @return A logical vector (TRUE for an outlier at `p < alpha`)
#' @examples
#' # Use outliersMD() to detect outliers in an anthropometric data from
#' # a SMART survey from the Democratic Republic of Congo (sp.ex01)
#' svy <- sp.ex01
#' svy[outliersMD(svy$height,svy$weight), ]
#' @export
#'
#
################################################################################

outliersMD <- function(x, y, alpha = 0.001) {
  df <- data.frame(x, y)
  md <- stats::mahalanobis(df,
                           colMeans(df, na.rm = TRUE),
                           stats::cov(df, use = "complete.obs"))
  p <- stats::pchisq(md, 2, lower.tail = FALSE)
  outlierMD <- (p < alpha)
  return(outlierMD)
}
