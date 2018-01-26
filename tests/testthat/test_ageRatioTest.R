library(nipnTK)
context("Tests for ageRatioTest")

svy <- dp.ex02
art <- ageRatioTest(svy$age, ratio = 0.85)

test_that("art is ageRatioTest", {
  expect_is(art, "ageRatioTest")
})
