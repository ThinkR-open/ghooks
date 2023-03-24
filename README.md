
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ghooks

<!-- badges: start -->
<!-- badges: end -->

The goal of `{ghooks}` is to provide \_\_GO\_\_lem \_\_HO\_\_oks for
\_\_ST\_\_andard `{shiny}` structures.

## Installation

You can install the development version of `{ghooks}` like so:

``` r
pak::pak("thinkr-open/ghooks")
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

## About

You’re reading the doc about version : 0.0.0.9000

This README has been compiled on:

``` r
Sys.time()
#> [1] "2023-03-24 20:53:34 CET"
```

Here are the test & coverage results :

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading ghooks
#> ── R CMD check results ────────────────────────────────── ghooks 0.0.0.9000 ────
#> Duration: 7.5s
#> 
#> 0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```

``` r
covr::package_coverage()
#> ghooks Coverage: 100.00%
#> R/detect_ui_line.R: 100.00%
#> R/geyser_hook.R: 100.00%
```
