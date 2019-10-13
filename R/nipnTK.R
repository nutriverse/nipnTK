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
#'     prop.test qqline qqnorm quantile sd var
#' @importFrom graphics abline axTicks axis barplot hist lines par plot rect
#'     strheight strwidth text
#' @importFrom bbw recode
#
################################################################################
"_PACKAGE"

## quiets concerns of R CMD check re: the psus and THRESHOLD that appear in bbw
#if(getRversion() >= "2.15.1")  utils::globalVariables(c("psu", "THRESHOLD"))

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
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{camp}}{Camp name code}
#' \item{\code{block}}{Block code}
#' \item{\code{age}}{Age (years)}
#' \item{\code{sex}}{Sex}
#' \item{\code{weight}}{Weight (kg)}
#' \item{\code{height}}{Height (cm)}
#' \item{\code{demispan}}{Demispan (cm)}
#' \item{\code{muac}}{Mid-upper arm circumference (cm)}
#' \item{\code{oedema}}{Oedema}
#' }
#' @source Data courtesy of \href{HelpAge International}{http://www.helpage.org}
"ah.ex01"


################################################################################
#
#' Example dataset for age and sex distributions function
#'
#' Data taken from household rosters collected as part of a household survey in
#' Tanzania.
#'
#' @format A data frame of 8736 observations and 2 variables
#' \describe{
#' \item{\code{age}}{Age (years)}
#' \item{\code{sex}}{Sex (1 = Male / 2 = Female)}
#' }
"as.ex01"


################################################################################
#
#' Example dataset for age and sex distributions function
#'
#' Census data of Tanzania taken from the Wolfram|Alpha knoweldge engine.
#'
#' @format A data frame with 20 observations and 4 variables
#' \describe{
#' \item{\code{age}}{Age group}
#' \item{\code{Males}}{Total male population}
#' \item{\code{Females}}{Total female population}
#' \item{\code{All}}{Total population}
#' }
#' @source \url{http://www.wolframalpha.com/input/?i=Tanzania+age+distribution}
"as.ex02"


################################################################################
#
#' Example dataset for distributions of variables and indices
#'
#' Anthropometric data from a SMART survey in Kabul, Afghanistan.
#'
#' @format A data frame with 873 observations and 11 variables
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{age}}{Age of child (months)}
#' \item{\code{sex}}{Gender of child}
#' \item{\code{weight}}{Weight of child (kgs)}
#' \item{\code{height}}{Height of child (cm)}
#' \item{\code{muac}}{Mid-upper arm circumference (mm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' \item{\code{haz}}{Height-for-age z-score}
#' \item{\code{waz}}{Weight-for-age z-score}
#' \item{\code{whz}}{Weight-for-height z-score}
#' \item{\code{flag}}{Data quality flag}
#' }
"dist.ex01"


################################################################################
#
#' Example dataset for digit preference function
#'
#' Anthropometric data from a single state from a Demographic and Health Survey
#' (DHS) of a West African country.
#'
#' @format A data frame with 796 observations and 6 variables
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{age}}{Age (months)}
#' \item{\code{sex}}{Gender}
#' \item{\code{wt}}{Weight (kg)}
#' \item{\code{ht}}{height (cm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' }
"dp.ex01"


################################################################################
#
#' Example dataset for digit preference function
#'
#' Anthropometric data from a SMART survey in Kabul, Afghanistan in a
#' comma-separated-value (CSV) file format. This is a survey of children aged
#' 6-59 months old.
#'
#' @format A data frame with 873 observations and 7 variables
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{age}}{Age of child (months)}
#' \item{\code{sex}}{Gender of child}
#' \item{\code{weight}}{Weight of child (kgs)}
#' \item{\code{height}}{Height of child (cm)}
#' \item{\code{muac}}{Mid-upper arm circumference (mm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' }
"dp.ex02"


################################################################################
#
#' Example dataset for digit preference
#'
#' Anthropometric data for a sample of children living in a refugee camp in a
#' West African country.
#'
#' @format A data frame with 374 observations and 6 variables
#' \describe{
#' \item{\code{age}}{Age (months)}
#' \item{\code{sex}}{Gender (1 = Male / 2 = Female)}
#' \item{\code{weight}}{Weight (kg)}
#' \item{\code{height}}{Height (cm)}
#' \item{\code{muac}}{Mid-upper arm circumference (mm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' }
"dp.ex03"


################################################################################
#
#' Example dataset for identifying outliers using flags
#'
#' Anthropometric data from a SMART survey in Sudan.
#'
#' @format A data frame with 786 observations and 11 variables
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{child}}{Child ID}
#' \item{\code{age}}{Age (months)}
#' \item{\code{sex}}{Gender (1 = Male / 2 = Female)}
#' \item{\code{weight}}{Weight (kg)}
#' \item{\code{height}}{Height (cm)}
#' \item{\code{muac}}{Mid-upper arm circumference (mm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' \item{\code{haz}}{Height-for-age z-score}
#' \item{\code{waz}}{Weight-for-age z-score}
#' \item{\code{whz}}{Weight-for-height z-score}
#' }
"flag.ex01"


################################################################################
#
#' Example dataset for identifying outliers using flags
#'
#' Anthropometric data from a survey of children 11 years or older attending
#' school in Ethiopia.
#'
#' @format A data.frame with 973 observations and 7 variables.
#' \describe{
#' \item{\code{school}}{School ID}
#' \item{\code{sex}}{Gender (1 = Male / 2 = Female)}
#' \item{\code{ageMonths}}{Age (months)}
#' \item{\code{weight}}{Weight (kg)}
#' \item{\code{height}}{Height (cm)}
#' \item{\code{haz}}{Height-for-age z-score}
#' \item{\code{baz}}{Body mass index (BMI)-for-age z-score}
#' }
"flag.ex02"


################################################################################
#
#' Example dataset for identifying outliers using flags
#'
#' Anthropometric data from a national survey in Nigeria.
#'
#' @format A data frame with 18330 observations and 10 variables
#' \describe{
#' \item{\code{psu}}{Primary sampling unit}
#' \item{\code{region}}{Region code}
#' \item{\code{state}}{State}
#' \item{\code{age}}{Age (months)}
#' \item{\code{sex}}{Gender (1 = Male / 2 = Female)}
#' \item{\code{weight}}{Weight (kg)}
#' \item{\code{height}}{Height (cm)}
#' \item{\code{haz}}{Height-for-age z-score}
#' \item{\code{waz}}{Weight-for-age z-score}
#' \item{\code{whz}}{Weight-for-height z-score}
#' }
"flag.ex03"


################################################################################
#
#' Example dataset for checking ranges and legal values
#'
#' Anthropometric data from a SMART survey in Angola.
#'
#' @format A data frame with 906 observations and 6 variables
#' \describe{
#' \item{\code{age}}{Age (months)}
#' \item{\code{sex}}{Gender (1 = Male / 2 = Female)}
#' \item{\code{weight}}{Weight (kg)}
#' \item{\code{height}}{Height (cm)}
#' \item{\code{muac}}{Mid-upper arm circumference (mm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' }
"rl.ex01"


################################################################################
#
#' Example dataset for using scatterplots to identify outliers
#'
#' Anthropometric data from a SMART survey in the Democratic Republic of Congo.
#'
#' @format A data frame with 895 observations and 6 variables
#' \describe{
#' \item{\code{age}}{Age (months)}
#' \item{\code{sex}}{Gender (1 = Male / 2 = Female)}
#' \item{\code{weight}}{Weight (kg)}
#' \item{\code{height}}{Height (cm)}
#' \item{\code{muac}}{Mid-upper arm circumference (mm)}
#' \item{\code{oedema}}{Presence or absence of oedema}
#' }
"sp.ex01"


################################################################################
#
#' Example dataset for using scatterplots to identify outliers
#'
#' Anthropometric data from a survey of school-age (i.e., between 5 and 15 years)
#' children from Pakistan
#'
#' @format A data frame with 849 observations and 9 variables
#' \describe{
#' \item{\code{region}}{Region code}
#' \item{\code{school}}{School code}
#' \item{\code{ageMonths}}{Age (months)}
#' \item{\code{sex}}{Sex (1 = Male / 2 = Female)}
#' \item{\code{weight}}{Weight (kg)}
#' \item{\code{height}}{Height (cm)}
#' \item{\code{haz}}{Height-for-age z-score}
#' \item{\code{waz}}{Weight-for-age z-score}
#' \item{\code{baz}}{Body mass index (BMI)-for-age z-score}
#' }
"sp.ex02"
