################################################################################
#
#' NiPN data quality toolkit
#'
#' An implementation of the National Information Platforms for Nutrition or
#' NiPN's analytic methods for assessing quality of anthropometric datasets that
#' include measurements of weight, height or length, middle upper arm
#' circumference, sex and age. The focus is on anthropometric status but many of
#' the presented methods could be applied to other variables. This is a library
#' of R functions for assessing data-quality in nutritional anthropometry
#' surveys.
#'
#' @docType package
#' @name nipnTK
#' @keywords internal
#' @importFrom stats IQR chisq.test cov dnorm mahalanobis na.omit pchisq pnorm
#'   prop.test qqline qqnorm quantile sd var
#' @importFrom graphics abline axTicks axis barplot hist lines par plot rect
#'   strheight strwidth text
#' @importFrom withr local_par
#'
#
################################################################################
"_PACKAGE"


