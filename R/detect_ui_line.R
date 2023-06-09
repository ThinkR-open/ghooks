# WARNING - Generated by {fusen} from /dev/flat_utils.Rmd: do not edit by hand

#' utils for the hooks
#'
#' @return line for the h1() in the ui
#' @noRd
#' @examples
#' detect_ui_line(
#'   system.file(
#'     "shinyexample/R/app_ui.R",
#'     package = "golem"
#'   )
#' )
#' detect_server_line(
#'     system.file(
#'       "shinyexample/R/app_server.R",
#'       package = "golem"
#'     )
#' )
detect_ui_line <- function(
  path = "R/app_ui.R"
) {
  grep(
    "h1\\(",
    readLines(
      path
    )
  )
}
#' @noRd
detect_server_line <- function(
 path = "R/app_server.R"
) {
  grep(
    "Your application server logic",
    readLines(
      path
    )
  )
}

