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
#' @return NULL
#' @examples
#' \dontrun{
#'   boxText(x = sum(par("usr")[1:2]) / 2,
#'           y = max(x$tab) * 0.1,
#'           labels = "(numbers on bars represent the proportions in each class)",
#'           cex = cex,
#'           pad = TRUE)
#' }
#' @export
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
  w <- strwidth(labels, cex = cex)
  w <- ifelse(pad, w + strwidth("w", cex = cex), w)
  h <- 2 * strheight(labels, cex = cex)
  rect(x - w / 2, y - h / 2, x + w / 2, y + h / 2, col = col, border = border, lwd = lwd)
  text(x, y, labels = labels, cex = cex)
}
