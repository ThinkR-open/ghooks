
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ghooks

<!-- badges: start -->

[![R-CMD-check](https://github.com/ThinkR-open/ghooks/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ThinkR-open/ghooks/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of `{ghooks}` is to provide `{ghooks}` hooks for standard
`{shiny}` apps.

## Installation

You can install the development version of `{ghooks}` like so:

``` r
pak::pak("thinkr-open/ghooks")
```

## About

You’re reading the doc about version : 0.0.0.9000

This README has been compiled on the

``` r
Sys.time()
[1] "2023-03-27 13:07:03 CEST"
```

Here are the test & coverage results :

``` r
devtools::check(quiet = TRUE)
ℹ Loading ghooks
── R CMD check results ────────────────────────────────── ghooks 0.0.0.9000 ────
Duration: 7.1s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```

``` r
covr::package_coverage()
ghooks Coverage: 100.00%
R/detect_ui_line.R: 100.00%
R/geyser_hook.R: 100.00%
```

## `{golem}` hooks

`{golem}` hooks are functions that are called by `{golem}` at specific
moments of the app lifecycle. They are used to add custom code to the
app, notably when creating the app with `create_golem()`.

You can find more info about `{golem}` hooks on [`{golem}`
documentation](https://thinkr-open.github.io/golem/articles/f_extending_golem.html).

The hooks can be called with `golem::create_golem(project_hook = )`,
when creating a new golem project via the RStudio widget, as show on the
screenshot in the [Extending
`{golem}`](https://thinkr-open.github.io/golem/articles/f_extending_golem.html#defining-your-own-project_hook)
Vignette.

Below is the list of curently available hooks:

### `geyser_hook`

This hook is mainly intended at demoing the `{golem}` hooks system. It
adds the “Old Faithful Geyser Data” app to your golem project.

<details>
<summary>
Click here to see the content of `app_ui` and `app_server` from
`geyser_hook`
</summary>

``` r
pth <- tempfile(pattern = "geyser")
old_wd <- getwd()
unlink(pth, recursive = TRUE)
golem::create_golem(
  pth,
  project_hook = ghooks::geyser_hook,
  open = FALSE
)
── Checking package name ───────────────────────────────────────────────────────
✔ Valid package name
── Creating dir ────────────────────────────────────────────────────────────────
✔ Creating '/var/folders/9w/zdlv83ws6csdjnfc5x819gtr0000gn/T/RtmpMxqJJS/geyserd84144e998b8/'
✔ Setting active project to '/private/var/folders/9w/zdlv83ws6csdjnfc5x819gtr0000gn/T/RtmpMxqJJS/geyserd84144e998b8'
✔ Creating 'R/'
✔ Writing a sentinel file '.here'
• Build robust paths within your project via `here::here()`
• Learn more at <https://here.r-lib.org>
✔ Setting active project to '<no active project>'
✔ Created package directory
── Copying package skeleton ────────────────────────────────────────────────────
✔ Copied app skeleton
── Running project hook function ───────────────────────────────────────────────
Styling  1  files:
 R/app_ui.R ℹ 
────────────────────────────────────────
Status  Count   Legend 
✔   0   File unchanged.
ℹ   1   File changed.
✖   0   Styling threw an error.
────────────────────────────────────────
Please review the changes carefully!
Styling  1  files:
 R/app_server.R ℹ 
────────────────────────────────────────
Status  Count   Legend 
✔   0   File unchanged.
ℹ   1   File changed.
✖   0   Styling threw an error.
────────────────────────────────────────
Please review the changes carefully!
✔ All set
✔ Setting active project to
'/private/var/folders/9w/zdlv83ws6csdjnfc5x819gtr0000gn/T/RtmpMxqJJS/geyserd84144e998b8'
── Done ────────────────────────────────────────────────────────────────────────
A new golem named geyserd84144e998b8 was created at /var/folders/9w/zdlv83ws6csdjnfc5x819gtr0000gn/T//RtmpMxqJJS/geyserd84144e998b8 .
To continue working on your app, start editing the 01_start.R file.
```

``` r
cat(
  readLines(
    file.path(pth, "R", "app_ui.R")
  ),
  sep = "\n"
)
#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      # Application title
      titlePanel("Old Faithful Geyser Data"),

      # Sidebar with a slider input for number of bins
      sidebarLayout(
        sidebarPanel(
          sliderInput(
            "bins",
            "Number of bins:",
            min = 1,
            max = 50,
            value = 30
          )
        ),

        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("distPlot")
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "geyserd84144e998b8"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
```

``` r
cat(
  readLines(
    file.path(pth, "R", "app_server.R")
  ),
  sep = "\n"
)
#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = "darkgray", border = "white")
  })
}
```

</details>

## About

You’re reading the doc about version : 0.0.0.9000

This README has been compiled on:

``` r
Sys.time()
[1] "2023-03-27 13:07:14 CEST"
```

Here are the test & coverage results :

``` r
devtools::check(quiet = TRUE)
ℹ Loading ghooks
── R CMD check results ────────────────────────────────── ghooks 0.0.0.9000 ────
Duration: 7.6s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```

``` r
covr::package_coverage()
ghooks Coverage: 100.00%
R/detect_ui_line.R: 100.00%
R/geyser_hook.R: 100.00%
```
