################################################################################
#
#' NiPN data quality toolkit
#'
#' This is a library of R functions for assessing data-quality in nutritional
#' anthropometry surveys.
#'
#' @docType package
#' @name nipnTK
#' @export
#' @importFrom
NULL

################################################################################
#
#' Example dataset for age heaping function
#'
#' Anthropometric data from a Rapid Assessment Method for Older People (RAM-OP)
#' survey in the Dadaab refugee camp in Garissa, Kenya. This is a survey of
#' people aged sixty years and older.
#'
#' @format A data frame with 593 observations and 10 variables
#' \describe{
#' \item{\code{psu}{Primary sampling unit}
#' \item{\code{camp}{Camp name code}
#' \item{\code{block}{Block code}
#' \item{\code{age}{Age (years)}
#' \item{\code{sex}{Sex}
#' \item{\code{weight}{Weight (kg)}
#' \item{\code{height}{Height (cm)}
#' \item{\code{demispan}{Demispan (cm)}
#' \item{\code{muac}{Mid-upper arm circumference (cm)}
#' \item{\code{oedema}{Oedema}
#' }
#' @source Data courtesy of \link{HelpAge International}{http://www.helpage.org}
"ah.ex01"
