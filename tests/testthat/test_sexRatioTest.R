library(nipnTK)
context("Tests for sexRatioTest")

svy <- as.ex01
ref <- as.ex02
censusM <- sum(ref$Males)
censusF <- sum(ref$Females)
srt <- sexRatioTest(svy$sex, codes = c(1, 2), pop = c(censusM, censusF))

test_that("srt is sexRatioTest", {
  expect_is(srt, "sexRatioTest")
})

test_that("str(srt) is list", {
  expect_true(is.list(srt))
})

test_that("names of srt", {
  expect_equal(names(srt)[1], "pM")
  expect_equal(names(srt)[2], "eM")
  expect_equal(names(srt)[3], "X2")
  expect_equal(names(srt)[4], "df")
  expect_equal(names(srt)[5], "p")
})

test_that("print(srt) message exists", {
  expect_output(print(srt))
})
