library(nipnTK)
context("Tests for ageHeaping() function")

svy <- dp.ex02
ah12 <- ageHeaping(svy$age)

test_that("ah12 is class ageHeaping", {
  expect_is(ah12, "ageHeaping")
})

test_that("ah12 is list", {
  expect_true(is.list(ah12))
})

test_that("length(ah12) is 5", {
  expect_equal(length(ah12), 5)
})

test_that("names of elements of ah12", {
  expect_match(names(ah12[1]), "X2")
  expect_match(names(ah12[2]), "df")
  expect_match(names(ah12[3]), "p")
  expect_match(names(ah12[4]), "tab")
  expect_match(names(ah12[5]), "pct")
})

test_that("plot(ah12) is NULL", {
  expect_is(plot(ah12), "NULL")
})


test_that("print(ah12) message exists", {
  expect_output(print(ah12))
})

expect_error(ageHeaping(as.character(svy$age)))

