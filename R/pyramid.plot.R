################################################################################
#
#' Pyramid plot function for creating population pyramids.
#'
#' @param x Vector of ages (usually grouped)
#' @param g Vector of groups (usually sex)
#' @param main Plot title
#' @param xlab `x-axis` label
#' @param ylab `y-axis` label
#' @param col Colours for bars. Either a single colour (default is
#'     `col = "white"`) for all bars, two colours (e.g. `col = c("lightblue", "pink")`)
#'     for left hand side bars and right hand side bars respectively, or many
#'     colours allocated on a `checkerboard` basis to each bar
#' @param ... Other graphical parameters
#'
#' @return A table of `x` by `g` (invisible)
#'
#' @examples
#' # Use pyramid.plot() on anthropometric data from a SMART survey in
#' # Kabul, Afghanistan (dp.ex02)
#' svy <- dp.ex02
#' pyramid.plot(svy$age, svy$sex)
#'
#' @export
#'
#
################################################################################

pyramid.plot <- function(x,
                         g,
                         main = paste("Pyramid plot of",
                                      deparse(substitute(x)), "by",
                                      deparse(substitute(g))),
                         xlab = paste(deparse(substitute(g)),
                                      "(", levels(as.factor(g))[1], "/",
                                      levels(as.factor(g))[2],")"),
                         ylab = deparse(substitute(x)), col = "white",
                         ...) {
  tab <- table(x, g); tab[ ,1] <- -tab[ ,1]
  if (length(col) == 2) {
    col = c(rep(col[1], times = nrow(tab)), rep(col[2], times = nrow(tab)))
  }
  graphics::barplot(tab,
                    horiz = TRUE, beside = TRUE,
                    space = c(0, -nrow(tab)),
                    names.arg = c(dimnames(tab)$x,
                                  dimnames(tab)$x),
                    xlim = c(min(tab) * 1.2, max(tab) * 1.2),
                    main = main, xlab = xlab, ylab = ylab,
                    col = col, axes = FALSE, ...)
  graphics::axis(side = 1,
                 labels = abs(axTicks(side = 1)),
                 at = (axTicks(side = 1)))
  invisible(abs(tab))
}
