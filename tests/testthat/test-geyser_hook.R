test_that("geyser_hook works", {
  pth <- tempfile(pattern = "geyser")
  dir.create(pth)
  on.exit(
    unlink(
      pth,
      recursive = TRUE,
      force = TRUE
    )
  )
  ui <- system.file(
    "shinyexample/R/app_ui.R",
    package = "golem"
  )
  server <- system.file(
    "shinyexample/R/app_server.R",
    package = "golem"
  )
  dir.create(
    file.path(
      pth,
      "R"
    )
  )
  file.copy(
    ui,
    file.path(
      pth,
      "R"
    )
  )
  file.copy(
    server,
    file.path(
      pth,
      "R/app_server.R"
    )
  )
  withr::with_options(
    c("styler.quiet" = TRUE),{
      geyser_hook(pth, "shinyexample")
    }
  )

  expect_true(
    grepl(
      "Old Faithful Geyser Data",
      paste(
        readLines(
          file.path(pth, "R/app_ui.R")
        ),
        collapse = ""
      )
    )
  )
  expect_true(
    grepl(
      "# Sidebar with a slider input for number of bins",
      paste(
        readLines(
          file.path(pth, "R/app_ui.R")
        ),
        collapse = ""
      )
    )
  )
  expect_true(
    grepl(
      "output\\$distPlot <- renderPlot",
      paste(
        readLines(file.path(pth, "R/app_server.R")),
        collapse = ""
      )
    )
  )
  expect_true(
    grepl(
      "histogram with the specified number of bins",
      paste(
        readLines(
          file.path(pth, "R/app_server.R")
        ),
        collapse = ""
      )
    )
  )
})
