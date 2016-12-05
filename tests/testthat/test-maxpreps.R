context("Scraping www.maxpreps.com...")

test_that("maxpreps_team_stats() returns data frame", {
  x <- maxpreps_team_stats("pacific union college prep", "falcons", "angwin", "ca", "basketball", "04-05")
  expect_is(x, "data.frame")
})

test_that("maxpreps_team_leaders() returns data frame", {
  x <- maxpreps_team_leaders("basketball", "scoring", "ca")
  expect_is(x, "data.frame")
})

test_that("maxpreps_team_leaders() returns data frame", {
  x <- maxpreps_indv_leaders("basketball", "scoring", "ca", "12", "pg")
  expect_is(x, "data.frame")
})
