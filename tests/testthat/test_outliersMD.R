library(nipnTK)
context("Tests for outliersMD")

svy <- sp.ex01
outmd <- svy[outliersMD(svy$height,svy$weight), ]


test_that("outmd is data.frame", {
  expect_is(outmd, "data.frame")
})


