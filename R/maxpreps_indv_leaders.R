#' Get individual leaders for various sports and categories
#'
#' Scrape individual leaderboards from www.maxpreps.com
#'
#' @param sport string
#' @param category string, will vary by sport
#' @param state string, two character state abbreviation, e.g. 'CA'
#' @param class_year alphanumeric selection of 9-12. 9 = Freshmen, 10 = Sophomore, etc.
#' @param position string, will vary by sport
#'
#' @return data frame
#' @export
#'
#' @examples
#' maxpreps_indv_leaders("basketball", "scoring", "ca", "12", "pg")
maxpreps_indv_leaders <- function(sport, category, state, class_year = NULL, position) {

  options(warn = -1)

  if (!missing(class_year)) {
    if (!class_year %in% 9:12 | !class_year %in% as.character(9:12)) stop("class_year must be one of 9, 10, 11, or 12")
  }

  if (missing(state)) {
    url <- sprintf("http://www.maxpreps.com/leaders/%s/,%s/stat-leaders.htm", sport, category)
  } else {
    url <- sprintf("http://www.maxpreps.com/leaders/%s/,%s/%s/stat-leaders.htm", sport, category, state)
  }
  if (!missing(class_year) | !missing(position)) {
    url <- paste0(url, "?")
  }
  if (!missing(class_year)) {
    url <- paste0(url, "classyear=", class_year)
  }
  if (!missing(position) | !missing(class_year)) {
    url <- paste0(url, "&position=", position)
  } else if (!missing(class_year) & missing(position)) {
    url <- paste0(url, "position=", position)
  }

  dat <- url %>%
    xml2::read_html() %>%
    rvest::html_nodes(".stat-leaders") %>%
    rvest::html_table() %>%
    data.frame()

  if (nrow(dat) == 0) stop("No data available. Visit maxpreps.com for available sports and statistics.")

  dat <- dat %>%
    janitor::clean_names() %>%
    tidyr::separate(name, into = c("athlete_name", "school_name"), sep = "-") %>%
    tidyr::separate(school_name, into = c("year", "school_name"), sep = 3)
  return(dat)
}
