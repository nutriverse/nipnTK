library(nipnTK)
context("Tests for pyramid.plot")

svy <- dp.ex02
pyplot <- pyramid.plot(svy$age, svy$sex)

test_that("pyplot is table", {
  expect_is(pyplot, "table")
})
