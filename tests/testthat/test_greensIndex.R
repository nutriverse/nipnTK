library(nipnTK)
context("Tests for greensIndex")

svy <- flag.ex01
svy$flag <- 0
svy$flag <- ifelse(!is.na(svy$haz) & (svy$haz < -6 | svy$haz > 6), svy$flag + 1, svy$flag)
svy$flag <- ifelse(!is.na(svy$whz) & (svy$whz < -5 | svy$whz > 5), svy$flag + 2, svy$flag)
svy$flag <- ifelse(!is.na(svy$waz) & (svy$waz < -6 | svy$waz > 5), svy$flag + 4, svy$flag)

test_that("flag is numeric", {
  expect_is(svy$flag, "numeric")
})

test_that("flag is <= 7", {
  test_flag <- function(x) {
    expect_true(x <= 7)
  }
  lapply(svy$flag, test_flag)
})

test_that("flag !is.na", {
  test_na <- function(x) {
    expect_true(!is.na(x))
  }
  lapply(svy$flag, test_na)
})
