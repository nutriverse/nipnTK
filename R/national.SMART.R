################################################################################
#
#' Add SMART flags to a stratified sample survey (e.g. MICS, DHS, national
#' SMART)
#'
#' @param x Survey dataset (as an R data.frame) with indices present
#' @param strata Name of column in `x` that defines the strata
#' @param indices Names of columns in `x` containing indices
#'
#' @return A data.frame with same structure as `x` with a `flagSMART`
#'   column added. This column is coded using sums of powers of two
#'
#' @examples
#' # Use the national.SMART() function to flag indices from a national
#' # SMART survey in Nigeria (flag.ex03)
#' svy <- flag.ex03
#' svyFlagged <- national.SMART(x = svy, strata = "state")
#'
#' # Exclude records with flagging codes relevant to whz:
#' svyFlagged <- svyFlagged[!(svyFlagged$flagSMART %in% c(2, 3, 6, 7)), ]
#'
#' @export
#'
#
################################################################################

national.SMART <- function(x, strata, indices = c("haz", "whz", "waz")) {
  result <- NULL
  for(i in sort(unique(x[[strata]]))) {
    stratumData <- x[x[[strata]] == i, ]
    stratumData$flagSMART <- 0
    lambda <- 0

    for(j in indices) {
      referenceMean <- mean(stratumData[[j]], na.rm = TRUE)
      stratumData$flagSMART <- ifelse(
        !is.na(stratumData[[j]]) &
          (stratumData[[j]] < (referenceMean - 3) |
             stratumData[[j]] > (referenceMean + 3)),
        stratumData$flagSMART + 2 ^ lambda, stratumData$flagSMART
      )
      lambda <- lambda + 1
    }
    result <- rbind(result, stratumData)
  }
  return(result)
}

