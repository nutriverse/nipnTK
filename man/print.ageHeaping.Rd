% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ageHeaping.R
\name{print.ageHeaping}
\alias{print.ageHeaping}
\title{\code{\link[=print]{print()}} helper functions for \code{\link[=ageHeaping]{ageHeaping()}} functions}
\usage{
\method{print}{ageHeaping}(x, ...)
}
\arguments{
\item{x}{Object resulting from applying the \code{\link[=ageHeaping]{ageHeaping()}} function}

\item{...}{Additional \code{\link[=print]{print()}} arguments}
}
\value{
Printed output of the \code{\link[=ageHeaping]{ageHeaping()}} function
}
\description{
\code{\link[=print]{print()}} helper functions for \code{\link[=ageHeaping]{ageHeaping()}} functions
}
\examples{
# Print age heaping test on SMART survey data in Kabul, Afghanistan (dp.ex02)
# using a divisor of 12
svy <- dp.ex02
ah12 <- ageHeaping(svy$age)
print(ah12)

}
