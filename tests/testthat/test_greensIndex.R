library(nipnTK)
context("Tests for greensIndex")

svy <- flag.ex01
svy$flag <- 0
svy$flag <- ifelse(!is.na(svy$haz) & (svy$haz < -6 | svy$haz > 6), svy$flag + 1, svy$flag)
svy$flag <- ifelse(!is.na(svy$whz) & (svy$whz < -5 | svy$whz > 5), svy$flag + 2, svy$flag)
svy$flag <- ifelse(!is.na(svy$waz) & (svy$waz < -6 | svy$waz > 5), svy$flag + 4, svy$flag)
svy <- svy[svy$flag == 0, ]
svy$stunted <- ifelse(svy$haz < -2, 1, 2)
gi <- greensIndex(data = svy, psu = "psu", case = "stunted")


test_that("gi is greensIndex", {
  expect_is(gi, "greensIndex")
})

test_that("gi is a list", {
  expect_true(is.list(gi))
})

test_that("names of elements of gi", {
  expect_equal(names(gi)[1], "GI")
  expect_equal(names(gi)[2], "LCL")
  expect_equal(names(gi)[3], "UCL")
  expect_equal(names(gi)[4], "minGI")
  expect_equal(names(gi)[5], "p")
})

test_that("length(gi) is 5", {
  expect_equal(length(gi), 5)
})

test_that("print(gi) message exists", {
  expect_output(print(gi))
})
