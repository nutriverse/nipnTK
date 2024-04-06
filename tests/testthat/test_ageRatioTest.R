library(nipnTK)
context("Tests for ageRatioTest")

svy <- dp.ex02
art <- ageRatioTest(svy$age, ratio = 0.85)

test_that("art is ageRatioTest", {
  expect_is(art, "ageRatioTest")
})

test_that("art is list", {
  expect_true(is.list(art))
})

test_that("names of art", {
  expect_equal(names(art)[1], "expectedR")
  expect_equal(names(art)[2], "expectedP")
  expect_equal(names(art)[3], "observedR")
  expect_equal(names(art)[4], "observedP")
  expect_equal(names(art)[5], "X2")
  expect_equal(names(art)[6], "df")
  expect_equal(names(art)[7], "p")
})

test_that("print(art) message exists", {
  expect_output(print(art))
})

## Test that function works when age has NAs

svy <- dp.ex02

svy$age[sample(seq_len(length(svy$age)), 5)] <- NA_integer_

art <- ageRatioTest(svy$age, ratio = 0.85)

test_that("art is ageRatioTest", {
  expect_is(art, "ageRatioTest")
})

test_that("art is list", {
  expect_true(is.list(art))
})

test_that("names of art", {
  expect_equal(names(art)[1], "expectedR")
  expect_equal(names(art)[2], "expectedP")
  expect_equal(names(art)[3], "observedR")
  expect_equal(names(art)[4], "observedP")
  expect_equal(names(art)[5], "X2")
  expect_equal(names(art)[6], "df")
  expect_equal(names(art)[7], "p")
})

test_that("print(art) message exists", {
  expect_output(print(art))
})

## Test that function works when age is numeric value

svy <- dp.ex02

svy$age <- as.numeric(svy$age)

art <- ageRatioTest(svy$age, ratio = 0.85)

test_that("art is ageRatioTest", {
  expect_is(art, "ageRatioTest")
})

test_that("art is list", {
  expect_true(is.list(art))
})

test_that("names of art", {
  expect_equal(names(art)[1], "expectedR")
  expect_equal(names(art)[2], "expectedP")
  expect_equal(names(art)[3], "observedR")
  expect_equal(names(art)[4], "observedP")
  expect_equal(names(art)[5], "X2")
  expect_equal(names(art)[6], "df")
  expect_equal(names(art)[7], "p")
})

test_that("print(art) message exists", {
  expect_output(print(art))
})

## Test that function works when age is integer ----

svy <- dp.ex02

svy$age <- as.integer(svy$age)

art <- ageRatioTest(svy$age, ratio = 0.85)

test_that("art is ageRatioTest", {
  expect_is(art, "ageRatioTest")
})

test_that("art is list", {
  expect_true(is.list(art))
})

test_that("names of art", {
  expect_equal(names(art)[1], "expectedR")
  expect_equal(names(art)[2], "expectedP")
  expect_equal(names(art)[3], "observedR")
  expect_equal(names(art)[4], "observedP")
  expect_equal(names(art)[5], "X2")
  expect_equal(names(art)[6], "df")
  expect_equal(names(art)[7], "p")
})

test_that("print(art) message exists", {
  expect_output(print(art))
})


## Test that function works when age is character value

svy <- dp.ex02

svy$age <- as.character(svy$age)

expect_error(ageRatioTest(svy$age))

