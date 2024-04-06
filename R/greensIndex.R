################################################################################
#
#' Green's Index of Dispersion
#'
#' Implementation of the Green's Index of Dispersion by bootstrap. The sampling
#' distribution of the Green's Index is not well described hence bootstrapping
#' is used to test whether the distribution of cases across primary sampling
#' units is random.
#'
#' The value of Green's Index can range between `-1/(n - 1)` for maximum
#' uniformity (specific to the dataset) and one for maximum clumping. The
#' interpretation of Green’s Index is straightforward:
#'
#' | **Green's Index Value** | **Interpretation** |
#' | :--- | :--- |
#' | *Green's Index close to 0* | Random |
#' | *Green's Index greater than 0* | Clumped (i.e. more clumped than random) |
#' | *Green’s Index less than 0* | Uniform (i.e. more uniform than random) |
#'
#' @param data Survey dataset (as an R data.frame)
#' @param psu Name of variable holding PSU (cluster) data as a character
#'   vector of length = 1 (e.g. `psu`)
#' @param case Name of variable holding case status as a character vector of
#'   length = 1 (e.g. *GAM*). The function assumes that case status is
#'   coded with 1 = case
#' @param replicates Number of bootstrap replicates (default is 9999)
#'
#' @returns A list of class `GI` with names:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *GI* | Estimate of Green's index |
#' | *LCL* | 95\\% LCL for GI |
#' | *UCL* | 95\\% UCL for GI |
#' | *minGI* | Minimum possible GI (maximum uniformity) for the data |
#' | *p* | `p-value` (H0: = Random distribution of cases across PSUs) |
#'
#' @examples
#' # Apply Green's Index using anthropometric data from a SMART survey in Sudan
#' # (flag.ex01)
#' svy <- flag.ex01
#' svy$flag <- 0
#' svy$flag <- ifelse(!is.na(svy$haz) & (svy$haz < -6 | svy$haz > 6),
#'                    svy$flag + 1, svy$flag)
#' svy$flag <- ifelse(!is.na(svy$whz) & (svy$whz < -5 | svy$whz > 5),
#'                    svy$flag + 2, svy$flag)
#' svy$flag <- ifelse(!is.na(svy$waz) & (svy$waz < -6 | svy$waz > 5),
#'                    svy$flag + 4, svy$flag)
#' svy <- svy[svy$flag == 0, ]
#' svy$stunted <- ifelse(svy$haz < -2, 1, 2)
#'
#' ## set seed to 0 to replicate results
#' set.seed(0)
#' greensIndex(data = svy, psu = "psu", case = "stunted")
#'
#' @export
#'
#
################################################################################

greensIndex <- function(data, psu, case, replicates = 999) {
  caseCounts <- table(data[[psu]], data[[case]])[ ,"1"]

  boot <- NULL

  for(i in 1:replicates) {
    counts <- sample(x = caseCounts, replace = TRUE)
    boot <- c(boot, (var(counts) / mean(counts) - 1) / (sum(counts) - 1))
  }

  GI <- round(stats::quantile(boot,
                              probs = c(0.5, 0.025, 0.975),
                              na.rm = TRUE), 4)

  p <- 1 - sum(boot > 0, na.rm = TRUE) / sum(!is.na(boot))

  if(GI[1] < 0) {
    p <- 1 - sum(boot < 0, na.rm = TRUE) / sum(!is.na(boot))
  }

  minGI <- -1 / (sum(caseCounts) - 1)
  result <- list(GI = GI[1], LCL = GI[2], UCL = GI[3], minGI = minGI, p = p)
  class(result) <- "greensIndex"
  return(result)
}


################################################################################
#
#' [print()] helper function for `print.greensIndex()` function
#'
#' @param x Object resulting from applying the [greensIndex()] function
#' @param ... Additional [print()] parameters
#'
#' @returns Printed output of [greensIndex()] function
#'
#' @examples
#' # Apply Green's Index using anthropometric data from a SMART survey in Sudan
#' # (flag.ex01)
#' svy <- flag.ex01
#' svy$flag <- 0
#' svy$flag <- ifelse(!is.na(svy$haz) & (svy$haz < -6 | svy$haz > 6), svy$flag + 1, svy$flag)
#' svy$flag <- ifelse(!is.na(svy$whz) & (svy$whz < -5 | svy$whz > 5), svy$flag + 2, svy$flag)
#' svy$flag <- ifelse(!is.na(svy$waz) & (svy$waz < -6 | svy$waz > 5), svy$flag + 4, svy$flag)
#' svy <- svy[svy$flag == 0, ]
#' svy$stunted <- ifelse(svy$haz < -2, 1, 2)
#' gi <- greensIndex(data = svy, psu = "psu", case = "stunted")
#' print(gi)
#'
#' @export
#'
#
################################################################################

print.greensIndex <- function(x, ...) {
  cat("\n\tGreen's Index of Dispersion\n\n", sep = "")
  cat("Green's Index (GI) of Dispersion  = ",
      formatC(x$GI, format = "f", flag = "+", width = 6),
      ", 95% CI = (", formatC(x$LCL, format = "f", flag = "+", width = 6), ", ",
      formatC(x$UCL, format = "f", flag = "+", width = 6), ")\n", sep = "")
  cat("Maximum uniformity for this data  = ",
      formatC(x$minGI, format = "f", flag = "+", width = 6), "\n", sep ="")
  cat("                         p-value  =  ",
      formatC(x$p, format = "f", width = 6), "\n\n", sep ="")
}
