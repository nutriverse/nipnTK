################################################################################
################################################################################
################################################################################
#
#  NiPN data quality toolkit
#
#    Version 1.11; 10th August 2017
#
#    This is a library of R functions for assessing data-quality in nutritional
#    anthropometry surveys.
#
#    Redistribution and use in both source and binary forms, with or without
#    modification, are permitted.
#
################################################################################
################################################################################
################################################################################


################################################################################
#
#  Goodness of fit to an expected (model-based) age distribution with print()
#  and plot() helper functions
#
################################################################################
#
#  Parameters :
#
#    age   Vector of ages
#
#    u5mr  Under fives years mortality rate as deaths / 10,000 persons / day
#
################################################################################
#
#  Returns :
#
#    A list of class "ageChildren" with:
#
#      u5mr      Under fives years mortality rate as deaths / 10K persons / day
#
#      observed  Table of counts in each (year-centred) age group
#
#      expected  Table of expected counts in each (year-centred) age group
#
#      X2        Chi-squared test statistic
#
#      df        Degrees of freedom for Chi-squared test
#
#      p         p-value for for Chi-squared test
#
################################################################################

ageChildren <- function(age, u5mr = 0, groups = "6:17=1; 18:29=2; 30:41=3; 42:53=4; 54:59=5")
  {
  ycag <- recode(age, "6:17=1; 18:29=2; 30:41=3; 42:53=4; 54:59=5")
  z <- (u5mr / 10000) * 365.25
  t <- 0:4
  p <- exp(-z * 0:4)
  d <- c(1, 1, 1, 1, 0.5)
  p <- d * p / sum(d * p)
  expected <- p * sum(table(ycag))
  names(expected) <- 1:5
  observed <- fullTable(ycag, values = 1:5)
  X2 <- sum((observed - expected)^2 / expected)
  pX2 <- pchisq(X2, df = 4, lower.tail = FALSE)
  result <- list(u5mr = u5mr, observed = observed, expected = expected, X2 = X2, df = 4, p = pX2)
  class(result) <- "ageChildren"
  return(result)
  }

print.ageChildren <- function(x)
  {
  cat("\n\tAge Test (Children)\n\n", sep = "")
  cat("X-squared = ", formatC(x$X2, format = "f", width = 6), ", df = ", x$df, ", p = ", formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
  }

plot.ageChildren <- function(x)
  {
  YLIM = c(0, max(max(x$observed), max(x$expected)))
  par(mfcol = c(1, 2))
  barplot(x$observed, main = "Observed", ylim = YLIM)
  barplot(x$expected, main = "Expected", ylim = YLIM)
  }


################################################################################
#
#  Age-heaping analysis with print() and plot() helper function
#
################################################################################
#
#  Parameters :
#
#    x        Vector of ages
#
#    divisor  divisor (usually 5, 6, 10, or 12)
#
################################################################################
#
#  Returns :
#
#    A list of class "ageHeaping" with:
#
#      X2   Chi-squared test statistic
#
#      df   Degrees of freedom for Chi-squared test
#
#      p    p-value for for Chi-squared test
#
#      tab  Table of remainders (for x %% divisor)
#
#      pct  Table of proportions (%) of remainders (for x %% divisor)
#
################################################################################

ageHeaping <- function(x, divisor = 12)
  {
  dataName <- deparse(substitute(x))
  r <- x %% divisor
  tab <- fullTable(r, values = 0:(divisor - 1))
  names(dimnames(tab)) <- paste("Remainder of ", dataName, " / ", divisor, sep = "")
  chiSq <- chisq.test(tab)
  pct <- round(prop.table(tab) * 100, 1)
  result <- list(X2 = chiSq$statistic, df = chiSq$parameter, p = chiSq$p.value, tab = tab, pct = pct)
  class(result) <- "ageHeaping"
  return(result)
  }

print.ageHeaping <- function(x)
  {
  cat("\n\tAge-heaping Analysis\n\n", sep = "")
  cat("data:\t", names(dimnames(x$tab)), "\n", sep = "")
  cat("X-squared = ", x$X2, ", df = ", x$df, ", p-value = ", formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
  }

plot.ageHeaping <- function(x, main = "",  xlab = "Remainder", ylab = "Frequency", cex = 0.75)
  {
  main <- ifelse(main == "", names(dimnames(x$tab)), main)
  plot(x$tab, main = main, xlab = xlab, ylab = ylab, frame.plot = FALSE, lwd = 3)
  abline(h = sum(x$tab) / length(x$tab), lty = 3)
  boxText(as.numeric(names(x$tab)), rep(max(x$tab) * 0.1, length(x$tab)), paste(sprintf(fmt = "%3.1f", x$pct), "%", sep = ""), cex = cex, pad = FALSE)
  }


################################################################################
#
# Age Ratio Test with print() helper function
#
################################################################################
#
#  Parameters :
#
#    x      Numeric vector (age)
#
#    ratio  Expected age ratio
#
################################################################################
#
#  Returns :
#
#    A list of class "ageRatioTest" with:
#
#      expectedR  Expected sex ratio
#
#      expectedP  Expected proportion aged 6:29 months
#
#      observedR  Observed sex ratio
#
#      observedP  Observed proportion aged 6:29 months
#
#      X2         Chi-squared test statistic
#
#      df         Degrees of freedom for Chi-squared test
#
#      p          p-value for for Chi-squared test
#
################################################################################

ageRatioTest <- function(x, ratio = 0.85)
  {
  g <- recode(x, "6:29=1; 30:59=2")
  expectedP <- ratio / (ratio + 1)
  observedP <- sum(g == 1)/ sum(table(g))
  observedR <- observedP / (1 - observedP)
  X2 <- prop.test(sum(g == 1), sum(table(g)), p = expectedP)
  result <- list(expectedR = ratio, expectedP = expectedP, observedR = observedR, observedP = observedP, X2 = X2$statistic, df = X2$parameter, p = X2$p.value)
  class(result) <- "ageRatioTest"
  return(result)
  }

print.ageRatioTest <- function(x)
  {
  cat("\n\t\tAge Ratio Test (children\'s data)\n\n", sep = "")
  cat("                    Expected age ratio = ", formatC(x$expectedR, format = "f", width = 6), "\n", sep = "")
  cat("Expected proportion aged 6 - 29 months = ", formatC(x$expectedP, format = "f", width = 6), "\n\n", sep = "")
  cat("                    Observed age ratio = ", formatC(x$observedR, format = "f", width = 6), "\n", sep = "")
  cat("Observed proportion aged 6 - 29 months = ", formatC(x$observedP, format = "f", width = 6), "\n\n", sep = "")
  cat("X-squared = ", formatC(x$X2, format = "f", width = 6), ", p = ", formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
  }


################################################################################
#
#  Plot text in a coloured bounding box
#
################################################################################
#
#  Paramters :
#
#    x, y    Co-ordinates of text is to be plotted
#
#    labels  Text to be plotted
#
#    cex     Character expansion
#
#    col     Background colour
#
#    border  Border colour
#
#    lwd     Border width
#
#    pad     Add padding to (L) and (R) ends of bounding box?
#
################################################################################
#
#  Returns :
#
#    NULL
#
################################################################################

boxText <- function(x , y, labels, cex = 0.75, col = "white", border = FALSE, lwd = 0.5, pad = TRUE)
  {
  w <- strwidth(labels, cex = cex)
  w <- ifelse(pad, w + strwidth("w", cex = cex), w)
  h <- 2 * strheight(labels, cex = cex)
  rect(x - w / 2, y - h / 2, x + w / 2, y + h / 2, col = col, border = border, lwd = lwd)
  text(x, y, labels = labels, cex = cex)
  }


################################################################################
#
#  Digit Preference Score with print() and plot() helper function
#
################################################################################
#
#  Parameters :
#
#    x       Numeric vector
#
#    digits  Number of decimal places in 'x'. Using "digits = 1" (e.g.) allows
#            105 to be treated as 105.0
#
#    values  A vector of possible values for the final digit (default = 0:9)
#
################################################################################
#
#  Returns :
#
#    A list of class "digitPreference" with:
#
#     dps     Digit Preference Score (DPS)
#
#     tab     Table of final digit counts
#
#     pct     Table of proportions (%) of final digit counts
#
################################################################################
#
#  DPS definition from:
#
#    Kari Kuulasmaa K, Hense HW, Tolonen H (for the WHO MONICA Project), Quality
#    Assessment of Data on Blood Pressure in the WHO MONICA Project, WHO MONICA
#    Project e-publications No. 9, WHO, Geneva, May 1998. Available from :
#
#        http://www.thl.fi/publications/monica/bp/bpqa.htm
#
################################################################################

digitPreference <- function(x, digits = 1, values = 0:9)
  {
  dataName <- deparse(substitute(x))
  x <- formatC(x, digits = digits, format = "f")
  finalDigit <- substr(x, nchar(x), nchar(x))
  tab <- fullTable(finalDigit, values = values)
  names(dimnames(tab)) <- dataName
  chiSq <- chisq.test(tab)
  pct <- round(prop.table(tab) * 100, 1)
  dps <- round(100 * sqrt(chiSq$statistic / (sum(chiSq$observed) * chiSq$parameter)), 2)
  dpsClass <- ifelse(dps < 8, "Excellent", ifelse(dps < 12, "Good", ifelse(dps < 20, "Acceptable", "Problematic")))
  names(dpsClass) <- "SMART DPS Class"
  names(dps) <- NULL
  result <- list(dps = dps, tab = tab, pct = pct, dpsClass = dpsClass)
  class(result) <- "digitPreference"
  return(result)
  }

print.digitPreference <- function(x)
  {
  cat("\n\tDigit Preference Score\n\n", sep = "")
  cat("data:\t", names(dimnames(x$tab)), "\n", sep = "")
  cat("Digit Preference Score (DPS) = ", x$dps, " (", x$dpsClass, ")\n\n", sep = "")
  }

plot.digitPreference <- function(x, main = "",  xlab = "Final Digit", ylab = "Frequency", cex = 0.75)
  {
  main <- ifelse(main == "", names(dimnames(x$tab)), main)
  main <- paste(main, " (DPS = ", x$dps, " : ", x$dpsClass, ")", sep = "")
  plot(x$tab, main = main, xlab = xlab, ylab = ylab, frame.plot = FALSE, lwd = 3)
  abline(h = sum(x$tab) / length(x$tab), lty = 3)
  boxText(as.numeric(names(x$tab)), rep(max(x$tab) * 0.2, length(x$tab)), paste(sprintf(fmt = "%3.1f", x$pct), "%", sep = ""), cex = cex, pad = FALSE)
  boxText(sum(par("usr")[1:2]) / 2, max(x$tab) * 0.1,"(numbers on bars represent the proportions in each class)", cex = cex, pad = TRUE)
  }


################################################################################
#
#  Fill out a one-dimensional table to include a specified range of values
#
################################################################################
#
#  Parameters :
#
#    x       A vector to tabulate
#
#    values  A vector of values to be included in a table. Default is:
#
#              min(x, na.rm = TRUE):max(x, na.rm = TRUE)
#
################################################################################
#
#  Returns :
#
#    A table object including zero cells
#
################################################################################

fullTable <- function(x, values = min(x, na.rm = TRUE):max(x, na.rm = TRUE))
  {
  tab <- NULL
  for(i in values)
    {
    tab <-c(tab, table(x)[as.character(i)])
    }
  tab[is.na(tab)] <- 0
  names(tab) <- as.character(values)
  return(as.table(tab))
  }


################################################################################
#
# Green's Index of Dispersion by bootstrap
#
################################################################################
#
#  Parameters :
#
#    data        Survey dataset (as an R data.frame)
#
#    psu         Name of variable holding PSU (cluster) data as a character
#                vector of length = 1 (e.g. "psu")
#
#    case        Name of variable holding case status as a character vector of
#                length = 1. (e.g. "GAM"). The function assumes that case status
#                is coded with 1 = case,
#
#    replicates  Number of bootstrap replicates (default is 9999)
#
################################################################################
#
#  Returns :
#
#    A list of class "GI" with names :
#
#      GI     Estimate of Green's index
#
#      LCL    95% LCL for GI
#
#      UCL    95% UCL for GI
#
#      minGI  Minimum possible GI (maximum uniformity) for the data
#
#      p      p-value (H0 := Random distribution of cases across PSUs)
#
################################################################################

greensIndex <- function(data, psu, case, replicates = 999)
  {
  caseCounts <- table(data[[psu]], data[[case]])[ ,"1"]
  set.seed(0)
  boot <- NULL
  for(i in 1:replicates)
    {
    counts <- sample(x = caseCounts, replace = TRUE)
    boot <- c(boot, (var(counts) / mean(counts) - 1) / (sum(counts) - 1))
    }
  GI <- round(quantile(boot, probs = c(0.5, 0.025, 0.975), na.rm = TRUE), 4)
  p <- 1 - sum(boot > 0, na.rm = TRUE) / sum(!is.na(boot))
  if(GI[1] < 0)
    {
    p <- 1 - sum(boot < 0, na.rm = TRUE) / sum(!is.na(boot))
    }
  minGI <- -1 / (sum(caseCounts) - 1)
  result <- list(GI = GI[1], LCL = GI[2], UCL = GI[3], minGI = minGI, p = p)
  class(result) <- "greensIndex"
  return(result)
  }

print.greensIndex <- function(x)
  {
  cat("\n\tGreen's Index of Dispersion\n\n", sep = "")
  cat("Green's Index (GI) of Dispersion  = ", formatC(x$GI, format = "f", flag = "+", width = 6), ", 95% CI = (", formatC(x$LCL, format = "f", flag = "+", width = 6), ", ", formatC(x$UCL, format = "f", flag = "+", width = 6), ")\n", sep = "")
  cat("Maximum uniformity for this data  = ", formatC(x$minGI, format = "f", flag = "+", width = 6), "\n", sep ="")
  cat("                         p-value  =  ", formatC(x$p, format = "f", width = 6), "\n\n", sep ="")
  }


################################################################################
#
#  Histogram with normal curve superimposed
#
################################################################################
#
#  Parameters :
#
#    x       A numeric vector
#
#    xlab    x-axis label
#
#    ylab    y-axis label
#
#    main    plot title
#
#    breaks  passed to hist() function (?hist for details)
#
#    ylim    y-axis limits
#
################################################################################
#
#  Returns :
#
#    NULL
#
################################################################################

histNormal <- function(x, xlab = deparse(substitute(x)), ylab = "Frequency", main = deparse(substitute(x)), breaks = "Sturges", ylim = NULL)
  {
  h <- hist(x, plot = FALSE, breaks = breaks)
  xfit <- seq(min(x, na.rm = TRUE), max(x, na.rm = TRUE), length = 100)
  yfit <- dnorm(xfit, mean = mean(x, na.rm = TRUE), sd = sd(x, na.rm = TRUE))
  yfit <- yfit * diff(h$mids[1:2]) * length(x)
  if(is.null(ylim))
    {
    ylim <- c(0, max(max(h$counts), max(yfit)))
    }
  hist(x, xlab = xlab, ylab = ylab, main = main, breaks = breaks, ylim = ylim)
  lines(xfit, yfit, lty = 3)
  }


################################################################################
#
# Add SMART flags to a stratified sample survey (e.g. MICS, DHS, national SMART)
#
################################################################################
#
#  Parameters :
#
#    x        Survey dataset (as an R data.frame) with indices present
#
#    strata   Name of column in 'x' that defines the strata
#
#    indices  Names of columns in 'x' containing indices
#
################################################################################
#
#  Returns :
#
#    A data.frame with same structure as 'x' with a 'flagSMART' column added.
#    This column is coded using sums of powers of two.
#
################################################################################

national.SMART <- function(x, strata, indices = c("haz", "whz", "waz"))
  {
  result <- NULL
  for(i in sort(unique(x[[strata]])))
    {
    stratumData <- x[x[[strata]] == i, ]
    stratumData$flagSMART <- 0
    lambda <- 0
    for(j in indices)
      {
      referenceMean <- mean(stratumData[[j]], na.rm = TRUE)
      stratumData$flagSMART <- ifelse(!is.na(stratumData[[j]]) & (stratumData[[j]] < (referenceMean - 3) | stratumData[[j]] > (referenceMean + 3)), stratumData$flagSMART + 2^lambda, stratumData$flagSMART)
      lambda <- lambda + 1
      }
     result <- rbind(result, stratumData)
    }
  return(result)
  }


################################################################################
#
# Mahalanobis distance to detect bivariate outliers
#
################################################################################
#
#  Parameters :
#
#    x      Numeric vector
#
#    y      Numeric vector
#
#    alpha  Critical alpha value to detect an outlier (defaults to 0.001)
#
################################################################################
#
#  Returns :
#
#    A logical vector (TRUE for an outlier at p < alpha)
#
################################################################################

outliersMD <- function(x, y, alpha = 0.001)
  {
  df <- data.frame(x, y)
  md <- mahalanobis(df, colMeans(df, na.rm = TRUE), cov(df, use = "complete.obs"))
  p <- pchisq(md, 2, lower.tail = FALSE)
  outlierMD <- (p < alpha)
  return(outlierMD)
  }


################################################################################
#
# IQR to detect univariate outliers
#
################################################################################
#
#  Parameters :
#
#    x      Numeric vector
#
#    fence  IQR multiplier (defaults to 1.5)
#
################################################################################
#
#  Returns :
#
#    A logical vector (TRUE for an outlier)
#
################################################################################

outliersUV <- function(x, fence = 1.5)
  {
  x <- x[!is.na(x)]
  iqr <- IQR(x)
  quartiles <- quantile(x, probs = c(0.25, 0.75))
  cat("\nUnivariate outliers : Lower fence = ", quartiles[1] - fence * iqr, ", Upper fence = ", quartiles[2] + fence * iqr, "\n\n", sep = "")
  outliers <- (x < quartiles[1] - fence * iqr) | (x > quartiles[2] + fence * iqr)
  return(outliers)
  }


################################################################################
#
#  Pyramid plot function
#
################################################################################
#
#  Parameters :
#
#    x      Vector of ages (usually grouped)
#
#    g      Vector of groups (usually sex)
#
#    main   Plot title
#
#    xlab   x-axis label
#
#    ylab   y-axis label
#
#    col    Colours for bars. Either a single colour (default is col = "white")
#           for all bars, two colours (e.g. col = c(“lightblue”, "pink") for
#           left hand side bars and right hand side bars respectively, or many
#           colours allocated on a "checkerboard" basis to each bar.
#
################################################################################
#
#  Returns :
#
#    A table of x by g (invisible)
#
################################################################################

pyramid.plot <- function(x, g, main = paste("Pyramid plot of", deparse(substitute(x)), "by", deparse(substitute(g))), xlab = paste(deparse(substitute(g)), "(", levels(as.factor(g))[1], "/", levels(as.factor(g))[2],")"), ylab = deparse(substitute(x)), col = "white", ...)
  {
  tab <- table(x, g); tab[ ,1] <- -tab[ ,1]
  if(length(col) == 2) {col = c(rep(col[1], times = nrow(tab)), rep(col[2], times = nrow(tab)))}
  barplot(tab, horiz = TRUE, beside = TRUE, space = c(0, -nrow(tab)), names.arg = c(dimnames(tab)$x, dimnames(tab)$x), xlim = c(min(tab) * 1.2, max(tab) * 1.2), main = main, xlab = xlab, ylab = ylab, col = col, axes = FALSE, ...)
  axis(side = 1, labels = abs(axTicks(side = 1)), at = (axTicks(side = 1)))
  invisible(abs(tab))
  }


################################################################################
#
#  Normal quantile-quantile plot
#
################################################################################
#
#  Parameters :
#
#    x  A numeric vector
#
################################################################################

qqNormalPlot <- function(x)
  {
  main = paste("Normal Q-Q plot for ", deparse(substitute(x)), sep = "")
  qqnorm(x, main = main, xlab = "Expected", ylab = "Observed", frame.plot = FALSE)
  qqline(x)
  }


################################################################################
#
#  Recode function
#
################################################################################
#
#  Parameters :
#
#    var	  Variable to recode
#
#    recodes  Character string of recode specifications :
#
#             Recode specifications in a character string separated by
#             semicolons of the form input=output as in:
#
#                 "1=1;2=1;3:6=2;else=NA"
#
#             If an input value satisfies more than one specification, then
#             the first (reading from left to right) is applied.
#
#             If no specification is satisfied, then the input value in 'var'
#             is carried over to the result unchanged.
#
#             NA is allowed on both input and output.
#
#             The following recode specifications are supported :
#
#             +---------------+------------------+---------------------------+
#             | Specification | Example          | Notes                     |
#             +---------------+------------------+---------------------------+
#             | Single values | 9=NA             |                           |
#             +---------------+------------------+---------------------------+
#             | Set of values | c(1,2,5)=1       | The left-hand-side is any |
#             |               | seq(1,9,2)='odd' | R function call that      |
#             |               | 1:10=1           | returns a vector          |
#             +---------------+------------------+---------------------------+
#             | Range of      | 7:9=3            | Special values lo and hi  |
#             | values        | lo:115=1         | may be used               |
#             +---------------+------------------+---------------------------+
#             | Other values  | else=NA          |                           |
#             +---------------+------------------+---------------------------+
#
#             Character values are quoted as in :
#
#                 recodes = "c(1,2,5)='sanitary';else='unsanitary'"
#
#             The output may be the (scalar) result of a function call as in:
#
#                 recodes = "999=median(var, na.rm = TRUE)"
#
#            Users are strongly advised to carefully check the results of
#            recode() calls with any outputs that are the results of a function
#            call.
#
#            The ouput may be the (scalar) value of a variable as in:
#
#                recodes = "999=scalarVariable"
#
#            If all of the output values are numeric, and if 'afr' is FALSE,
#            then a numeric result is returned; if var is a factor then
#            (by default) so is the result.
#
#    afr     Return a factor
#
#            Default is TRUE if 'var' is a factor and is FALSE otherwise
#
#    anr     Coerce result to numeric (default is TRUE)
#
#    levels  Order of the levels in the returned factor; the default is to use
#            the sort order of the level names.
#
################################################################################
#
#  Returns :
#
#    Recoded variable
#
################################################################################

recode <- function(var, recodes, afr, anr = TRUE, levels)
  {
  squeezeBlanks <- function(text)
    {
    gsub(" *", "",  text)
    }
  recodes <- gsub("\n|\t", " ", recodes)
  recode.list <- rev(strsplit(recodes, ";")[[1]])
  is.fac <- is.factor(var)
  if (missing(afr)) afr <- is.fac
  if (is.fac) var <- as.character(var)
  result <- var
  if (is.numeric(var))
    {
    lo <- min(var, na.rm = TRUE)
    hi <- max(var, na.rm = TRUE)
    }
  for (term in recode.list)
    {
    if (0 < length(grep(":", term)))
      {
      range <- strsplit(strsplit(term, "=")[[1]][1], ":")
      low <- eval(parse(text = range[[1]][1]))
      high <- eval(parse(text = range[[1]][2]))
      target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
      result[(var >= low) & (var <= high)] <- target
      }
    else if (0 < length(grep("^else=", squeezeBlanks(term))))
      {
      target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
      result[1:length(var)] <- target
      }
    else
      {
      set <- eval(parse(text = strsplit(term, "=")[[1]][1]))
      target <- eval(parse(text = strsplit(term, "=")[[1]][2]))
      for (val in set)
        {
        if (is.na(val)) result[is.na(var)] <- target else result[var == val] <- target
        }
      }
    }
  if (afr)
    {
    result <- if (!missing(levels)) factor(result, levels = levels) else as.factor(result)
    }
    else if (anr && (!is.numeric(result)))
      {
      result.valid <- na.omit(result)
      opt <- options(warn = -1)
      result.valid <- as.numeric(result.valid)
      options(opt)
      if (!any(is.na(result.valid))) result <- as.numeric(result)
      }
  return(result)
  }


################################################################################
#
#  Sex Ratio Test with print() helper function
#
################################################################################
#  Parameters :
#
#    sex    Numeric vector (sex)
#
#    codes  Codes used to identify males and females (in that order)
#
#    pop    Relative populations of males and females (in that order)
#
################################################################################
#
#  Returns :
#
#    A list of class "sexRatioTest" with:
#
#      pM  Observed proportion male
#
#      eM  Expected proportion male
#
#      X2  Chi-squared test statistic
#
#      df  Degrees of freedom for Chi-squared test
#
#      p   p-value for for Chi-squared test
#
################################################################################

sexRatioTest <- function(sex, codes = c(1, 2), pop = c(1, 1))
  {
  nM <- sum(sex == codes[1], na.rm = TRUE)
  nF <- sum(sex == codes[2], na.rm = TRUE)
  eM <- pop[1] / (pop[1] + pop[2])
  X2 <- prop.test(nM, nM + nF, p = eM)
  result <- list(pM = X2$estimate, eM = eM, X2 = X2$statistic, df = X2$parameter, p = X2$p.value)
  class(result) <- "sexRatioTest"
  return(result)
  }

print.sexRatioTest <- function(x)
  {
  cat("\n\tSex Ratio Test\n\n", sep = "")
  cat("Expected proportion male = ", formatC(x$eM, format = "f", width = 6), "\n", sep = "")
  cat("Observed proportion male = ", formatC(x$pM, format = "f", width = 6), "\n", sep = "")
  cat("X-squared = ", formatC(x$X2, format = "f", width = 6), ", p = ", formatC(x$p, format = "f", width = 6), "\n\n", sep = "")
  }


################################################################################
#
# Skew and kurtosis with print() helper function
#
################################################################################
#
#  Parameters :
#
#    x      Numeric vector
#
################################################################################
#
#  Returns :
#
#    A list of class "skewKurt" with:
#
#      s     Skewness with direction
#
#      s.se  Standard error of skewness
#
#      s.z   Test statistic (s.z = s / s.se)
#
#      s.p   p-value (s != 0)
#
#      k     Excess kurtosis with direction
#
#      k.se  Standard error of excess kurtosis
#
#      k.z   Test statistic (k.z = k / k.se)
#
#      k.p   p-value (k != 0)
#
################################################################################

skewKurt <- function(x)
  {
  x <- x[!is.na(x)]
  n <- length(x)
  x <- x - mean(x)
  s <- sqrt(n) * sum(x^3) / (sum(x^2)^(3/2))
  s.se <- sqrt((6 * n * (n - 1)) / ((n - 2) * (n + 1) * (n + 3)))
  s.z <- s / s.se
  s.p <- 2 * pnorm(abs(s.z), lower.tail = FALSE)
  k <- (n * sum(x^4)/(sum(x^2)^2)) - 3
  k.se <- 2 * s.se * sqrt((n^2 - 1) / ((n - 3) * (n + 5)))
  k.z <- k / k.se
  k.p <- 2 * pnorm(abs(k.z), lower.tail = FALSE)
  result <- list(s = s, s.se = s.se, s.z = s.z, s.p = s.p, k = k, k.se = k.se, k.z = k.z, k.p = k.p)
  class(result) <- "skewKurt"
  return(result)
  }

print.skewKurt <- function(x)
  {
  cat("\n\tSkewness and kurtosis\n\n", sep = "")
  cat("Skewness = ", formatC(x$s, format = "f", flag = "+", width = 6), "\tSE = ", formatC(x$s.se, format = "f", width = 6), "\tz = ", formatC(abs(x$s.z), format = "f", width = 6), "\tp = ", formatC(x$s.p, format = "f", width = 6), "\n", sep = "")
  cat("Kurtosis = ", formatC(x$k, format = "f", flag = "+", width = 6), "\tSE = ", formatC(x$k.se, format = "f", width = 6), "\tz = ", formatC(abs(x$k.z), format = "f", width = 6), "\tp = ", formatC(x$k.p, format = "f", width = 6), "\n\n", sep = "")
  }
