allow_install <- isTRUE(as.logical(Sys.getenv(
  "AAGI_AUTO_INSTALL",
  unset = interactive()
)))

# Conditional messaging (prefers cli for nicer output)
have_cli <- requireNamespace("cli", quietly = TRUE)

msg <- function(...) {
  txt <- sprintf(...)
  if (have_cli) {
    cli::cli_alert_info(txt)
  } else {
    message("[setup] ", txt)
  }
}

warn <- function(...) {
  txt <- sprintf(...)
  if (have_cli) {
    cli::cli_alert_warning(txt)
  } else {
    warning("[setup] ", txt, call. = FALSE)
  }
}

# Silently load a package if available
try_library <- function(pkg) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    suppressPackageStartupMessages(library(pkg, character.only = TRUE))
    TRUE
  } else {
    FALSE
  }
}

# ---------------------------------------------------------------------------
# Validate environment
# ---------------------------------------------------------------------------

if (!exists("params")) {
  stop(
    "[setup] 'params' not found. Source this script from a document render.",
    call. = FALSE
  )
}

# ---------------------------------------------------------------------------
# Package management
# ---------------------------------------------------------------------------

# Ensure pak is available for better installation
if (allow_install && !requireNamespace("pak", quietly = TRUE)) {
  tryCatch(
    {
      install.packages(
        "pak",
        repos = sprintf(
          "https://r-lib.github.io/p/pak/stable/%s/%s/%s",
          .Platform$pkgType,
          R.Version()$os,
          R.Version()$arch
        )
      )
    },
    error = function(e) warn("Failed to install pak: %s", e$message)
  )
}

# Install a package (CRAN or GitHub)
ensure_pkg <- function(pkg, github = NULL) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    return(invisible(TRUE))
  }

  if (!allow_install) {
    return(invisible(FALSE))
  }

  use_pak <- requireNamespace("pak", quietly = TRUE)
  target <- github %||% pkg

  # Skip GitHub installs without pak
  if (!is.null(github) && !use_pak) {
    return(invisible(FALSE))
  }

  tryCatch(
    {
      if (use_pak) {
        pak::pak(target, dependencies = TRUE)
      } else {
        install.packages(
          pkg,
          dependencies = TRUE,
          repos = getOption("repos", default = "https://cloud.r-project.org")
        )
      }
      invisible(TRUE)
    },
    error = function(e) invisible(FALSE)
  )
}

# Install packages (CRAN and GitHub)
all_pkgs <- c("ggplot2", "flextable", "cli", "ragg")
for (pkg in all_pkgs) {
  ensure_pkg(pkg)
}

for (pkg in c("AAGIThemes", "AAGIPalettes")) {
  ensure_pkg(pkg, github = sprintf("AAGI-AUS/%s", pkg))
}

# ---------------------------------------------------------------------------
# University configuration
# ---------------------------------------------------------------------------

uni_code <- params$uni %||% "CU"
uni_info <- params$uni_info[[uni_code]] %||% list(name = uni_code)
uni_name <- uni_info$name %||% uni_code

# ---------------------------------------------------------------------------
# Graphics device setup
# ---------------------------------------------------------------------------

use_ragg <- requireNamespace("ragg", quietly = TRUE)
is_latex <- knitr::is_latex_output()

default_dev_args <- list(width = 7, height = 5)
png_dev_args <- list(width = 7, height = 5, units = "in", res = 300)

# Select graphics device based on capabilities
set_device <- function(dev, args, label) {
  knitr::opts_chunk$set(dev = dev, dev.args = args)
  msg("Graphics device: %s", label)
}

if (use_ragg && is_latex) {
  set_device(ragg::agg_tiff, default_dev_args, "ragg::agg_tiff (LaTeX/PDF)")
} else if (use_ragg) {
  set_device(ragg::agg_png, png_dev_args, "ragg::agg_png (raster)")
} else if (.Platform$OS.type == "unix" && capabilities("cairo")) {
  dev <- if (is_latex) grDevices::cairo_pdf else "png"
  args <- if (is_latex) default_dev_args else png_dev_args
  label <- if (is_latex) "cairo_pdf (LaTeX/PDF)" else "png/cairo (raster)"
  set_device(dev, args, label)
} else {
  set_device("png", png_dev_args, "png (fallback)")
}

# Common knitr defaults
knitr::opts_chunk$set(fig.path = "figures/", fig.pos = "H")

# ---------------------------------------------------------------------------
# Load and configure libraries
# ---------------------------------------------------------------------------

try_library("ggplot2")

if (
  try_library("AAGIThemes") &&
    exists("theme_aagi", where = asNamespace("AAGIThemes"), mode = "function")
) {
  try(theme_set(theme_aagi()), silent = TRUE)
  msg("AAGIThemes loaded and applied.")
}

try_library("AAGIPalettes")
try_library("flextable")

# Configure flextable with AAGI theme if available
if (exists("set_flextable_defaults", mode = "function")) {
  try(
    set_flextable_defaults(
      theme_fun = if (exists("theme_ft_aagi", where = .GlobalEnv)) {
        theme_ft_aagi
      } else {
        NULL
      }
    ),
    silent = TRUE
  )
}

# ---------------------------------------------------------------------------
# Expose variables to knit environment and completion message
# ---------------------------------------------------------------------------

assign("uni_name", uni_name, envir = knitr::knit_global())

if (have_cli) {
  cli::cli_alert_success("Setup complete. uni_name={.val {uni_name}}")
} else {
  message(sprintf("[setup] Setup complete. uni_name=%s", uni_name))
}
