################################################################################
#
#' NiPN data quality toolkit
#'
#' This is a library of R functions for assessing data-quality in nutritional
#' anthropometry surveys.
#'
#' @docType package
#' @name nipnTK
#' @keywords internal
#' @importFrom stats IQR chisq.test cov dnorm mahalanobis na.omit pchisq pnorm
#'   prop.test qqline qqnorm quantile sd var
#' @importFrom graphics abline axTicks axis barplot hist lines par plot rect
#'   strheight strwidth text
#' @importFrom bbw recode
#' @importFrom withr local_par
#'
#
################################################################################
"_PACKAGE"

## quiets concerns of R CMD check re: the psus and THRESHOLD that appear in bbw
#if(getRversion() >= "2.15.1")  utils::globalVariables(c("psu", "THRESHOLD"))

