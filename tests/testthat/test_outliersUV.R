library(nipnTK)
context("Tests for outliersUV")

svy <- rl.ex01
outuv <- svy[outliersUV(svy$muac), ]

test_that("outuv is data.frame", {
  expect_is(outuv, "data.frame")
})
