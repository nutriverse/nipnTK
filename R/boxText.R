################################################################################
#
#' Plot text in a coloured bounding box.
#'
#' @param x,y Co-ordinates of text that is to be plotted
#' @param labels Text to be plotted
#' @param cex Character expansion
#' @param col Background colour
#' @param border Border colour
#' @param lwd Border width
#' @param pad Add padding to (L) and (R) ends of bounding box
#'
#' @returns NULL
#'
#' @examples
#' ## Use of boxtext in the ageHeaping plot function
#' svy <- dp.ex02
#' ah12 <- ageHeaping(svy$age)
#'
#' plot.new()
#' boxText(x = as.numeric(names(ah12$tab)),
#'         y = max(ah12$tab) * 0.1,
#'         labels = paste(sprintf(fmt = "%3.1f", ah12$pct), "%", sep = ""),
#'         cex = 0.5,
#'         pad = TRUE)
#'
#' @export
#'
#
################################################################################

boxText <- function(x,
                    y,
                    labels,
                    cex = 0.75,
                    col = "white",
                    border = FALSE,
                    lwd = 0.5,
                    pad = TRUE) {
  w <- graphics::strwidth(labels, cex = cex)
  w <- ifelse(pad, w + graphics::strwidth("w", cex = cex), w)
  h <- 2 * graphics::strheight(labels, cex = cex)
  graphics::rect(x - w / 2, y - h / 2, x + w / 2, y + h / 2,
                 col = col, border = border, lwd = lwd)
  graphics::text(x, y, labels = labels, cex = cex)
}
