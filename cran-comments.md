## Release summary

This is a patch release of `nipnTK`. This release is for general updates and routine maintenance upkeep.

## Test environments
* local OS X install, R 4.5.2
* local ubuntu 22.04 install, R 4.5.2
* win-builder (devel, release, and old release)
* github actions windows-latest, r: release
* github actions macOS-latest, r: release
* github actions ubuntu-24.04, r: release, devel, old release
* rhub windows-latest r devel
* rhub ubuntu 24.04 r devel
* rhub macos r devel
* rhub macos-arm64 r devel

## R CMD check results

### Local checks

0 errors | 0 warnings | 0 notes

### win-builder checks - devel and release

0 errors | 0 warnings | 0 notes

### win-builder checks - old release

0 errors | 0 warnings | 1 note

Author field differs from that derived from Authors@R
  Author:    'Mark Myatt [aut, cph] (ORCID: <https://orcid.org/0000-0003-1119-1474>), Ernest Guevarra [aut, cre, cph] (ORCID: <https://orcid.org/0000-0002-4887-4415>), Pascale Fritsch [aut], Katja Siling [aut], HelpAge International [cph], Elrha [fnd]'
  Authors@R: 'Mark Myatt [aut, cph] (<https://orcid.org/0000-0003-1119-1474>), Ernest Guevarra [aut, cre, cph] (<https://orcid.org/0000-0002-4887-4415>), Pascale Fritsch [aut], Katja Siling [aut], HelpAge International [cph], Elrha [fnd]'

Both author information are the same but ORCID records are formatted differently.

### GitHub Actions checks

0 errors | 0 warnings | 0 notes

### rhub checks

0 errors | 0 warnings | 0 notes

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies
`nipnTK` doesn't have any downstream / reverse dependencies 
(see https://github.com/nutriverse/nipnTK/tree/main/revdep/cran.md)
