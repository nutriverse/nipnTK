###############################################################################
#
# Recode
#
# Utility function that recodes variables based on user recode specifications.
# Handles both numeric or factor variables.
#
# @param var Variable to recode
# @param recodes Character string of recode specifications:
#   \itemize{
#     \item Recode specifications in a character string separated by
#     semicolons of the form \code{input=output} as in:
#         \code{"1=1;2=1;3:6=2;else=NA"}
#
#     \item If an input value satisfies more than one specification, then the
#     first (reading from left to right) is applied
#
#     \item If no specification is satisfied, then the input value is carried
#     over to the result unchanged
#
#     \item \code{NA} is allowed on both input and output
#
#     \item The following recode specifications are supported:
#
#         \tabular{lll}{
#           \strong{Specification} \tab \strong{Example}          \tab \strong{Notes}                                                 \cr
#           Single values          \tab \code{9=NA}               \tab                                                                \cr
#           Set of values          \tab \code{c(1,2,5)=1}         \tab The left-hand-side is any R function call that returns a vector\cr
#                                  \tab \code{seq(1,9,2)='odd'}   \tab                                                                \cr
#                                  \tab \code{1:10=1}             \tab                                                                \cr
#           Range of values        \tab \code{7:9=3}              \tab Special values \code{lo} and \code{hi} may be used             \cr
#                                  \tab \code{lo:115=1}           \tab                                                                \cr
#           Other values           \tab \code{else=NA}            \tab
#         }
#
#     \item Character values are quoted as in :
#
#          \code{recodes = "c(1,2,5)='sanitary' else='unsanitary'"}
#
#     \item The output may be the (scalar) result of a function call as in:
#
#          \code{recodes = "999=median(var, na.rm = TRUE)"}
#
#     \item Users are advised to carefully check the results of \code{recode()} calls
#     with any outputs that are the results of a function call.
#
#     \item The output may be the (scalar) value of a variable as in:
#
#          \code{recodes = "999=scalarVariable"}
#
#     \item If all of the output values are numeric, and if \code{'afr'} is \code{FALSE},
#     then a numeric result is returned; if \code{var} is a factor then
#     (by default) so is the result.
# }
# @param afr Return a factor. Default is TRUE if \code{var} is a factor and is
#   FALSE otherwise
# @param anr Coerce result to numeric (default is TRUE)
# @param levels Order of the levels in the returned factor; the default is to use
#    the sort order of the level names.
# @return Recoded variable
#
#
################################################################################

recode <- function(var, recodes, afr, anr = TRUE, levels) {
  squeezeBlanks <- function(text) {
    gsub(" *", "",  text)
  }
  recodes <- gsub("\n|\t", " ", recodes)
  recode.list <- rev(strsplit(recodes, ";")[[1]])
  is.fac <- is.factor(var)
  if (missing(afr)) afr <- is.fac
  if (is.fac) var <- as.character(var)
  result <- var
  if (is.numeric(var)) {
    lo <- min(var, na.rm = TRUE)
    hi <- max(var, na.rm = TRUE)
  }
  for (term in recode.list) {
    if (0 < length(grep(":", term))) {
      range <- strsplit(strsplit(term, "=")[[1]][1], ":")
      low <- eval(parse(text = range[[1]][1]))
      high <- eval(parse(text = range[[1]][2]))
      target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
      result[(var >= low) & (var <= high)] <- target
    } else if (0 < length(grep("^else=", squeezeBlanks(term)))) {
      target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
      result[1:length(var)] <- target
      } else {
        set <- eval(parse(text = strsplit(term, "=")[[1]][1]))
        target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
      for (val in set) {
        if (is.na(val)) result[is.na(var)] <- target else result[var == val] <- target
      }
    }
  }
  if (afr) {
    result <- if (!missing(levels)) factor(result, levels = levels) else as.factor(result)
  } else if (anr && (!is.numeric(result))) {
      result.valid <- na.omit(result)
      withr::with_options(
        new = list(warn = -1),
        code = {
          result.valid <- as.numeric(result.valid)
      #options(opt)
          if (!any(is.na(result.valid))) result <- as.numeric(result)
        }
      )
  }
  return(result)
}
