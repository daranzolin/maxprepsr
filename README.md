
<!-- README.md is generated from README.Rmd. Please edit that file -->
Introduction
------------

Are you a high school athlete who loves to gaze at their own stats? Or are you a nerdy peer who likes to throw shade via snarky charts? Good news: `maxprepsr` is for both of you. With minimal input, you can scrape most of MaxPreps' tabular data into R. Perfect for the nerd-athlete.

**What is MaxPreps?**

I'll let them explain:

> MaxPreps is America's Source for High School Sports. We are proud to be involved with America's hometown heroes – the young men and women working hard to improve their skills, place team above self, and serve as inspirations to their local communities. MaxPreps aspires to cover every team, every game and every player. We do this in partnership with nearly 100,000 varsity coaches throughout the United States.

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
-   Use `maxpreps_team_leaders()` to scrape team leaderboards.
-   Use `maxpreps_indv_leaders()` to scrape individual leaderboards.

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
-   More sports
-   More tests
