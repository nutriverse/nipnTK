library(nipnTK)
context("Tests for skewKurt")

svy <- dist.ex01
sk <- skewKurt(svy$muac)

test_that("sk is skewKurt", {
  expect_is(sk, "skewKurt")
})

test_that("str(sk) is list", {
  expect_true(is.list(sk))
})

test_that("print(sk) message exists", {
  expect_output(print(sk))
})


