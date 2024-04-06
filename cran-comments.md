## Release summary

Second CRAN release of `nipnTK`. In this release:

* Resolved issue with `ageRatioTest()` not working properly when age has
missing values

* Resolved issue with `ageRatioTest()` not providing appropriate results when
age values are numeric

* Updated general package documentation

* Added CITATION entry

## Test environments
* local ubuntu 22.04 install, R 4.3.3
* macos-latest (on GitHub Actions), release
* windows-latest (on GitHub Actions), release
* ubuntu-latest (on GitHub Actions), release, devel, and oldrelease
* mac-builder (release)
* win-builder (devel, release, oldrelease)
* rhub (windows-devel, fedora-devel, ubuntu-release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies
`nipnTK` doesn't have any downstream / reverse dependencies 
(see https://github.com/nutriverse/nipnTK/tree/main/revdep/cran.md)
