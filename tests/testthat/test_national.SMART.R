library(nipnTK)
context("Tests for national.SMART")

svy <- flag.ex03
svyFlagged <- national.SMART(x = svy, strata = "state")

test_that("flagSMART is numeric", {
  expect_is(svyFlagged$flagSMART, "numeric")
})


test_that("flagSMART is <= 7", {
  test_flag <- function(x) {
    expect_true(x <= 7)
  }
  lapply(svyFlagged$flagSMART, test_flag)
})


test_that("flag !is.na", {
  test_na <- function(x) {
    expect_true(!is.na(x))
  }
  lapply(svyFlagged$flagSMART, test_na)
})
