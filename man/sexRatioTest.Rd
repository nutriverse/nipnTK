% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sexRatioTest.R
\name{sexRatioTest}
\alias{sexRatioTest}
\title{Sex Ratio Test}
\usage{
sexRatioTest(sex, codes = c(1, 2), pop = c(1, 1))
}
\arguments{
\item{sex}{A vector of values that indicate sex}

\item{codes}{Codes used to identify males and females (in that order)}

\item{pop}{Relative populations of males and females (in that order)}
}
\value{
A list of class \code{"sexRatioTest"} with:\tabular{ll}{
   \strong{Variable} \tab \strong{Description} \cr
   \emph{pM} \tab Observed proportion male \cr
   \emph{eM} \tab Expected proportion male \cr
   \emph{X2} \tab Chi-squared test statistic \cr
   \emph{df} \tab Degrees of freedom for Chi-squared test \cr
   \emph{p} \tab \code{p-value} for Chi-squared test \cr
}
}
\description{
Sex Ratio Test
}
\examples{
# Use sexRatioTest() on household roster data from a survey in Tanzania
# (as.ex01) and census data of Tanzania extracted from Wolfram|Alpha knowledge
# engine (as.ex02)
svy <- as.ex01
ref <- as.ex02
censusM <- sum(ref$Males)
censusF <- sum(ref$Females)
sexRatioTest(svy$sex, codes = c(1, 2), pop = c(censusM, censusF))

}
