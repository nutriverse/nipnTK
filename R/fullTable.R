################################################################################
#
#' Fill out a one-dimensional table to include a specified range of values
#'
#' @param x A vector to tabulate
#' @param values A vector of values to be included in a table. Default is:
#'   `min(x, na.rm = TRUE):max(x, na.rm = TRUE)`
#'
#' @returns A table object including zero cells
#'
#' @examples
#' # Generate some artificial data and then apply `fullTable()`
#' set.seed(0)
#' finalDigits <- sample(x = 0:9, size = 1000, replace = TRUE)
#' fullTable(finalDigits)
#'
#' @export
#'
#
################################################################################

fullTable <- function(x, values = min(x, na.rm = TRUE):max(x, na.rm = TRUE)) {
  tab <- NULL

  for(i in values) {
    tab <-c(tab, table(x)[as.character(i)])
  }

  tab[is.na(tab)] <- 0
  names(tab) <- as.character(values)
  
  as.table(tab)
}
