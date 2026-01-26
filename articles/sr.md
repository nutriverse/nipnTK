# Sex ratio

The male to female sex ratio test checks whether the ratio of the number
of males to the number of females in a survey sample is similar to an
expected ratio. The expected male to female sex ratio can be calculated
from census or similar data. If there is no expected value then it is
usually assumed that there should be equal numbers of males and females
in the survey sample. This is usually true for children and young adults
but may not be true for older adults.

We will retrieve a survey dataset:

``` r
svy <- read.table("dp.ex02.csv", header = TRUE, sep = ",")
head(svy)
```

    #>   psu age sex weight height muac oedema
    #> 1   1   6   1    7.3   65.0  146      2
    #> 2   1  42   2   12.5   89.5  156      2
    #> 3   1  23   1   10.6   78.1  149      2
    #> 4   1  18   1   12.8   81.5  160      2
    #> 5   1  52   1   12.1   87.3  152      2
    #> 6   1  36   2   16.9   93.0  190      2

The dataset `dp.ex02.csv` is a comma-separated-value (CSV) file
containing anthropometric data from a SMART survey in Kabul,
Afghanistan.

It is reported that there are about 2.658 million boys and 2.508 million
girls aged between zero and four years in Afghanistan (2012 estimates).

The male to female sex ratio is:

``` r
2.658 / 2.508
```

which is:

    #> [1] 1.059809

It is often easier to work with the proportion of the population that is
male:

``` r
2.658 / (2.658 + 2.508)
```

which is:

    #> [1] 0.514518

We compare this to the proportion of the sample that is male:

``` r
table(svy$sex)
```

this gives:

    #> 
    #>   1   2 
    #> 438 435

This table is more useful when the cell counts are expressed as
proportions:

``` r
prop.table(table(svy$sex))
```

this gives:

    #> 
    #>         1         2 
    #> 0.5017182 0.4982818

A formal test can be made:

``` r
prop.test(table(svy$sex), p = 0.514518)
```

This returns:

    #> 
    #>  1-sample proportions test with continuity correction
    #> 
    #> data:  table(svy$sex), null probability 0.514518
    #> X-squared = 0.5225, df = 1, p-value = 0.4698
    #> alternative hypothesis: true p is not equal to 0.514518
    #> 95 percent confidence interval:
    #>  0.4680459 0.5353752
    #> sample estimates:
    #>         p 
    #> 0.5017182

The male to female sex ratio (expressed as the proportion male) in the
example data is not significantly different from the expected male to
female sex ratio (expressed as the proportion male).

The NiPN data quality toolkit provides an R language function called
[`sexRatioTest()`](https://nutriverse.io/nipnTK/reference/sexRatioTest.md)
that performs a sex ratio test:

``` r
sexRatioTest(svy$sex, codes = c(1, 2), pop = c(2.658, 2.508))
```

which returns:

    #> 
    #>  Sex Ratio Test
    #> 
    #> Expected proportion male = 0.5145
    #> Observed proportion male = 0.5017
    #> X-squared = 0.5225, p = 0.4698

The codes used in the sex variable for male and female are specified
using the codes parameter. If (e.g.) `sex` were coded using **M** and
**F** then you would specify `codes = c("M", "F")`.

Population data are specified using the `pop` parameter (males then
females). This can be specified as numbers or as a ratio. The test above
could have been specified as:

``` r
sexRatioTest(svy$sex, codes = c(1, 2), pop = c(1.059809, 1))
#> 
#>  Sex Ratio Test
#> 
#> Expected proportion male = 0.5145
#> Observed proportion male = 0.5017
#> X-squared = 0.5225, p = 0.4698
```

If (e.g.) you want to specify a one to one sex ratio then you would use
`pop = c(1, 1)`.

The observed sex ratio at birth is 1.06:1.00 (males to females). This
could be used to assess if selective abortion or female infanticide is
taking place although a large sample size (i.e. about n = 6200) is
required for such a test to have sufficient power.

## Analysis by age

The sex ratio test may be performed on each age group separately. You
can apply the sex ratio test to each age-group using the
[`by()`](https://rdrr.io/r/base/by.html) function:

``` r
svy$ycag <- recode(svy$age, "6:17=1; 18:29=2; 30:41=3; 42:53=4; 54:59=5") 
by(svy$sex, svy$ycag, sexRatioTest, codes = c(1, 2), pop = c(2.658, 2.508))
#> svy$ycag: 1
#> 
#>  Sex Ratio Test
#> 
#> Expected proportion male = 0.5145
#> Observed proportion male = 0.4879
#> X-squared = 0.4845, p = 0.4864
#> 
#> ------------------------------------------------------------ 
#> svy$ycag: 2
#> 
#>  Sex Ratio Test
#> 
#> Expected proportion male = 0.5145
#> Observed proportion male = 0.5152
#> X-squared = 0.0000, p = 1.0000
#> 
#> ------------------------------------------------------------ 
#> svy$ycag: 3
#> 
#>  Sex Ratio Test
#> 
#> Expected proportion male = 0.5145
#> Observed proportion male = 0.5228
#> X-squared = 0.0374, p = 0.8466
#> 
#> ------------------------------------------------------------ 
#> svy$ycag: 4
#> 
#>  Sex Ratio Test
#> 
#> Expected proportion male = 0.5145
#> Observed proportion male = 0.4875
#> X-squared = 0.3657, p = 0.5454
#> 
#> ------------------------------------------------------------ 
#> svy$ycag: 5
#> 
#>  Sex Ratio Test
#> 
#> Expected proportion male = 0.5145
#> Observed proportion male = 0.4627
#> X-squared = 0.5280, p = 0.4674
```

Note that the variable `ycag` created above holds the
year-centred-age-group.

This approach assumes that the sex ratio is independent of age.

An approach that does not make this assumption is to use the numbers of
male and female children in the same age-ranges in the population taken
from census data.

A useful source of census data is the [United States Census Bureau’s
International Data
Base](https://www.census.gov/data-tools/demo/idb/informationGateway.php):

<https://www.census.gov/data-tools/demo/idb/informationGateway.php>

This source gives the following estimates for Afghanistan in 2016:

[TABLE]

We need to ensure we use the same age-ranges as the census:

``` r
svy$ageGroup <- recode(svy$age, "0:11=0; 12:23=1; 24:35=2; 36:47=3; 48:59=4")
```

and then test the sex ratio in each age group separately:

``` r
sexRatioTest(svy$sex[svy$ageGroup == 0], pop = c(594602, 573956)) sexRatioTest(svy$sex[svy$ageGroup == 1], pop = c(550593, 533579)) sexRatioTest(svy$sex[svy$ageGroup == 2], pop = c(526827, 510479)) sexRatioTest(svy$sex[svy$ageGroup == 3], pop = c(509048, 493185)) sexRatioTest(svy$sex[svy$ageGroup == 4], pop = c(493521, 478137))
```

    #> 
    #>  Sex Ratio Test
    #> 
    #> Expected proportion male = 0.5088
    #> Observed proportion male = 0.5047
    #> X-squared = 0.0000, p = 1.0000
    #> 
    #>  Sex Ratio Test
    #> 
    #> Expected proportion male = 0.5078
    #> Observed proportion male = 0.4901
    #> X-squared = 0.1885, p = 0.6642
    #> 
    #>  Sex Ratio Test
    #> 
    #> Expected proportion male = 0.5079
    #> Observed proportion male = 0.5374
    #> X-squared = 0.6800, p = 0.4096
    #> 
    #>  Sex Ratio Test
    #> 
    #> Expected proportion male = 0.5079
    #> Observed proportion male = 0.5052
    #> X-squared = 0.0000, p = 0.9978
    #> 
    #>  Sex Ratio Test
    #> 
    #> Expected proportion male = 0.5079
    #> Observed proportion male = 0.4552
    #> X-squared = 1.4098, p = 0.2351

All of these tests find no significant differences between the observed
and expected sex ratios. It should be noted that some (or all) of the
tests might be based on small sample sizes:

``` r
table(svy$ageGroup)
#> 
#>   0   1   2   3   4 
#> 107 202 227 192 145
```

and may, therefore, be able to detect only large differences.

## Sex ratios in adults

With data from children we usually expect something like a one to one
male to female sex ratio. This will not usually be the case with adults,
especially older adults.

We will retrieve a survey dataset:

``` r
svy <- read.table("ah.ex01.csv", header = TRUE, sep = ",") 
head(svy)
```

    #>   psu camp block age sex weight height demispan muac oedema
    #> 1   1  IFO   A01  90   1   40.8  159.3     77.2 20.0      2
    #> 2   1  IFO   A01  60   2   69.8  155.3     78.3 35.3      2
    #> 3   1  IFO   A01  63   2   51.7  156.8     80.5 25.5      2
    #> 4   1  IFO   A01  74   2   61.1  158.9     83.5 27.0      2
    #> 5   1  IFO   A01  65   2   55.1  156.9     85.5 24.5      2
    #> 6   1  IFO   A01  62   2   56.7  158.1     86.3 26.1      2

The dataset `ah.ex01` is a comma-separated-value (CSV) file containing
anthropometry data from a Rapid Assessment Method for Older People
(RAM-OP) survey in the Dadaab refugee camps in Garissa, Kenya. This is a
survey of older people, defined as people aged sixty years and older.

With this type of survey it is usually possible to use camp
administration data to find the expected male to female sex ratio. This
information was not given in the RAM-OP survey report.

The camp population is predominantly Somali. It is reported that there
are 188 thousand men and 220 thousand women aged sixty years and older
in Somalia (2010 estimates). The sex ratio is:

``` r
188 / 220
```

which is:

    #> [1] 0.8545455

The expected proportion of the population that is male is:

``` r
188 / (188 + 220)
```

which is:

    #> [1] 0.4607843

The proportion of the sample that is male:

``` r
prop.table(table(svy$sex))
```

is:

    #> 
    #>        1        2 
    #> 0.381113 0.618887

This looks to be much smaller than the expected proportion. The sex
ratio test:

``` r
sexRatioTest(svy$sex, codes = c(1, 2), pop = c(188, 220))
```

reports:

    #> 
    #>  Sex Ratio Test
    #> 
    #> Expected proportion male = 0.4608
    #> Observed proportion male = 0.3811
    #> X-squared = 14.8305, p = 0.0001

The proportion of males in the sample is significantly smaller than we
expected.

This result could be due to the extraordinary nature of the population
(e.g. the camp population could really have very many more older women
than older men). It could also due to a selection bias in the survey. In
this example, men were more likely than women to be away from home
during the day and a household sample taken during the day would have
systematically excluded the more active members of the male population.

Note that the sex ratio test only applies to population surveys. If
surveys focus on (e.g.) carers of small children then the observed male
to female sex ratio is likely to be strongly biased towards women. In
such cases it is not sensible to apply a sex ratio test.
