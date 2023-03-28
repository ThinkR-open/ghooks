#' shinydashboard hook
#'
#' This hook creates a shinydashboard applications taken from
#' https://rstudio.github.io/shinydashboard/get_started.html.
#' It is mainly inteded as a simple example of how to
#' use the `project_hook` argument of `create_golem()`.
#'
#' @return Used for side effect
#' @inheritParams golem::project_hook
#' @export
#'
#' @examples
#' if (FALSE){
#'   pth <- tempfile(pattern = "shinydashboard")
#'   golem::create_golem(pth, project_hook = shinydashboard_hook)
#'   readLines(file.path(pth, "R/app_ui.R"))
#'   unlink(pth, recursive = TRUE)
#' }
shinydashboard_hook <- function(path, package_name, ...) {
  browser()
  withr::with_dir(path, {
    usethis::use_package("shinydashboard")
    shinydashboard_hook_replace_in_ui()
    shinydashboard_hook_replace_in_server()
  })
}

shinydashboard_hook_replace_in_ui <- function() {
  ui_line <- detect_ui_line()
  ui_lines <- readLines("R/app_ui.R")
  ui_lines[ui_line] <- '
     shinydashboard::dashboardPage(
      shinydashboard::dashboardHeader(title = "Basic dashboard"),
      shinydashboard::dashboardSidebar(),
      shinydashboard::dashboardBody(
        # Boxes need to be put in a row (or column)
        fluidRow(
          shinydashboard::box(plotOutput("plot1", height = 250)),

          shinydashboard::box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      )
    )'
  # replace fluidpage as well
  ui_lines <- ui_lines[-c(ui_line - 1, ui_line + 1)]
  writeLines(ui_lines, "R/app_ui.R")
  styler::style_file("R/app_ui.R")
}

shinydashboard_hook_replace_in_server <- function() {
  server_line <- detect_server_line()
  server_lines <- readLines("R/app_server.R")
  server_lines[server_line] <- '# Your application server logic
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })'
  writeLines(server_lines, "R/app_server.R")
  styler::style_file("R/app_server.R")
}
