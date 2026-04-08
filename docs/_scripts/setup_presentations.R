allow_install <- isTRUE(as.logical(Sys.getenv(
  "AAGI_AUTO_INSTALL",
  unset = interactive()
)))

ensure_pkg <- function(pkg, github = NULL) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    return(invisible(TRUE))
  }
  if (!allow_install) {
    stop(
      sprintf("Package '%s' is required but not installed.", pkg),
      call. = FALSE
    )
  }

  if (!requireNamespace("pak", quietly = TRUE)) {
    install.packages(
      "pak",
      repos = sprintf(
        "https://r-lib.github.io/p/pak/stable/%s/%s/%s",
        .Platform$pkgType,
        R.Version()$os,
        R.Version()$arch
      )
    )
  }
  pak::pak(github %||% pkg, dependencies = TRUE)
  invisible(TRUE)
}

# CRAN pkgs
for (p in c("ggplot2", "dplyr", "flextable", "gapminder", "gt")) {
  ensure_pkg(p)
}

# GitHub pkgs
ensure_pkg("AAGIThemes", github = "AAGI-AUS/AAGIThemes")
ensure_pkg("AAGIPalettes", github = "AAGI-AUS/AAGIPalettes")

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(flextable)
  library(gapminder)
  library(gt)
  library(AAGIThemes)
  library(AAGIPalettes)
})
