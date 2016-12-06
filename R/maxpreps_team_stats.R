#' Get team roster and statistics if available
#'
#' Scrape the specified team's roster and statistics pages from www.maxpreps.com
#'
#' @param school string
#' @param mascot string
#' @param city string
#' @param state string, two character state abbreviation, e.g. 'CA'
#' @param sport string
#' @param year string, in the format: 06-07, 09-10, etc.
#'
#' @return data frame
#' @export
#'
#' @examples
#' maxpreps_team_stats("pacific union college prep", "falcons", "angwin", "ca", "basketball", "04-05")
maxpreps_team_stats <- function(school, mascot, city, state, sport, year) {
  hyphen_text <- function(x) {
    tolower(gsub(" ", "-", x))
  }
  if (nchar(state) > 2) stop("state argument must be two character abbreviation.")
  if (sport %in% c("volleyball", "soccer", "football")) {
    year <- unlist(strsplit(year, "-"))[1]
  } else if (sport == "baseball") {
    year <- unlist(strsplit(year, "-"))[2]
  }

  school <- paste(hyphen_text(school), paste0(hyphen_text(mascot), "-"), sep = "-")
  location <- paste0("(", hyphen_text(city), ",", state, ")")
  base_url <- paste0("http://www.maxpreps.com/high-schools/", school, location)

  season <- switch(sport,
                   "basketball" = "winter",
                   "volleyball" = "fall",
                   "soccer" = "fall",
                   "football" = "fall",
                   "baseball" = "spring")

  roster_url <- paste0(base_url, "/", sport, "-", season, "-", year, "/roster.htm")
  stats_url <- paste0(base_url, "/", sport, "-", season, "-", year, "/stats.htm")

  roster <- roster_url %>%
    xml2::read_html() %>%
    rvest::html_nodes("#roster") %>%
    rvest::html_table() %>%
    data.frame()

  if (nrow(roster) == 0) stop("No data available")

  roster <- roster %>%
    janitor::clean_names()

  stats_data <- stats_url %>%
    xml2::read_html() %>%
    rvest::html_nodes(".stats-grid") %>%
    rvest::html_table() %>%
    purrr::map(~ janitor::clean_names(.))

  if (length(stats_data) == 0) {
    warning("No stats have been entered for this team")
    return(roster)
  }

  stats_data <- stats_data[order(sapply(stats_data, nrow), decreasing = TRUE)]

  stats_data <- stats_data %>%
    purrr::reduce(dplyr::left_join, by = c("x", "athlete_name")) %>%
    dplyr::filter(!is.na(x))

  all_data <- stats_data %>%
    dplyr::left_join(roster, by = "x")
  return(all_data)
}
