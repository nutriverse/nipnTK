## Resubmission
This is a resubmission. In this version I have:

* I have removed the `dontrun{}` wrap around the example for `boxText()`
  function and edited the example to be able to run

* I have used `withr::local_par` to be able to change `par` settings within a
  function and then revert back to original `par` settings. I am more familiar
  with using this approach as I have used it before compared to using `on.exit` 
  as suggested by CRAN reviewer. I think the same output is achieved. I will
  learn the `on.exit` function for future use. Thank you for the suggestion.
  
* I have removed the `set.seed(0)` in the `greensIndex()` function and then in
  the example I show that I apply `set.seed(0)` before using the `greensIndex()`
  function.

## Test environments
* local R installation, R 4.0.3
* ubuntu 20.04 (on GitHub Actions), R 4.0.3
* ubuntu 20.04 (on GitHub Actions), R devel
* windows latest (on GitHub Actions), R 4.0.3
* macOS latest (on GitHub Actions), R 4.0.3
* win-builder (devel, release, old-release)
* rhub (windows-devel, fedora-devel, ubuntu-release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

* Possibly mis-spelled words in DESCRIPTION:
  Anthropometric (3:13)
  NiPN (3:8)
  anthropometric (17:59, 19:49)
  
  - These are not mis-spelled.
