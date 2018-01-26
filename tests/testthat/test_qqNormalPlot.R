library(nipnTK)
context("Tests for qqNormalPlot")

svy <- dist.ex01
qqNormalPlot(svy$muac)
qqNormalPlot(svy$haz)
qqNormalPlot(svy$waz)
qqNormalPlot(svy$whz)

test_that("qqNormalPlot is NULL", {
  expect_is(qqNormalPlot(svy$muac), "NULL")
})
