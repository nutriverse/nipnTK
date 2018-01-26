library(nipnTK)
context("Tests for digitPreference")

svy <- dp.ex01
dp <- digitPreference(svy$wt, digits = 1)

test_that("dp is digitPreference", {
  expect_is(dp, "digitPreference")
})

test_that("dp is list", {
  expect_true(is.list(dp))
})

test_that("names of dp", {
  expect_equal(names(dp)[1], "dps")
  expect_equal(names(dp)[2], "tab")
  expect_equal(names(dp)[3], "pct")
  expect_equal(names(dp)[4], "dpsClass")
})

test_that("plot(dp) is NULL", {
  expect_is(plot(dp), "NULL")
})

test_that("print(dp) message exists", {
  expect_output(print(dp))
})
