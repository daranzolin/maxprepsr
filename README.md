
<!-- README.md is generated from README.Rmd. Please edit that file -->
Introduction
------------

Are you a high school athlete who loves to gaze at their own stats? Or are you a proud parent who loves to boast about their children? Good news: `maxprepsr` is for you.

Installation
------------

`maxprepsr` is not on CRAN, but can be installed via:

``` r
devtools::install_github("daranzolin/maxprepsr")
library(maxprepsr)
```

Usage
-----

There are three functions at present:

-   Use `maxpreps_team_stats()` to scrape a team's roster and statistics.
-   Use `maxpreps_team_leaders()` to scrape team leaderboards
-   Use `maxpreps_indv_leaders()` to scrape individual leaderboards

**Exhibit A**

``` r
suppressPackageStartupMessages(library(dplyr))
prep <- maxpreps_team_stats("pacific union college prep", "falcons", "angwin", "ca", "basketball", "04-05")
prep %>% 
  select(name, to) %>% 
  arrange(desc(as.numeric(to))) %>% 
  slice(1)
#>             name to
#> 1 David Ranzolin 82
```

Yea, I turned the ball over a lot.

Future Work
-----------

-   Vignette
-   Cleaner data returned (see that as.numeric()? Yikes)
-   Better querying
-   More tests
