#' Get team leaders for various sports and categories
#'
#' Scrape team leaderboards from www.maxpreps.com
#'
#' @param sport string
#' @param category string, will vary by sport
#' @param state string, two character state abbreviation, e.g. 'CA'
#'
#' @return data frame
#' @export
#'
#' @examples
#' maxpreps_team_leaders("basketball", "scoring", "ca")
maxpreps_team_leaders <- function(sport, category, state) {

  if (missing(state)) {
    url <- sprintf("http://www.maxpreps.com/leaders/%s/,%s/team-leaders.htm", sport, category)
  } else {
    url <- sprintf("http://www.maxpreps.com/leaders/%s/,%s/%s/team-leaders.htm", sport, category, state)
  }

  dat <- url %>%
    xml2::read_html() %>%
    rvest::html_nodes(".stat-leaders") %>%
    rvest::html_table() %>%
    data.frame()

  if (nrow(dat) == 0) stop("No data available. Visit maxpreps.com for available sports and statistics.")

  dat <- dat %>%
    janitor::clean_names()
  return(dat)
}
