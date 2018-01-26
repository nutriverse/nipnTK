library(nipnTK)
context("Tests for histNormal")

svy <- dist.ex01
histNormal(svy$muac)
histNormal(svy$haz)
histNormal(svy$waz)
histNormal(svy$whz)

test_that("histNormal is NULL", {
  expect_is(histNormal(svy$muac), "NULL")
})

test_that("histNormal on non-numeric", {
  expect_error(histNormal(svy$oedema))
})
