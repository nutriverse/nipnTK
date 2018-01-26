library(nipnTK)
context("Test ageChildren")

svy <- dp.ex02
ac <- ageChildren(svy$age, u5mr = 1)

test_that("ac is class ageChildren", {
  expect_is(ac, "ageChildren")
})

test_that("ac is list", {
  expect_true(is.list(ac))
})

test_that("names of elements of ac", {
  expect_match(names(ac[1]), "u5mr")
  expect_match(names(ac[2]), "observed")
  expect_match(names(ac[3]), "expected")
  expect_match(names(ac[4]), "X2")
  expect_match(names(ac[5]), "df")
  expect_match(names(ac[6]), "p")
})

test_that("plot(ac) is matrix", {
  expect_is(plot(ac), "matrix")
})


test_that("print(ac) message exists", {
  expect_output(print(ac))
})
