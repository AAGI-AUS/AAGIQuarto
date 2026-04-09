# AAGI Quarto setup (reports)
# - Optional auto-install via pak/CRAN (controlled by AAGI_AUTO_INSTALL)
# - Safe when params are missing (presentations etc.)
# - Avoids knitr device width/height duplication (do NOT pass width/height in
#   dev.args)

allow_install <- isTRUE(as.logical(Sys.getenv(
  "AAGI_AUTO_INSTALL",
  unset = interactive()
)))

`%||%` <- function(x, y) if (is.null(x)) y else x

# Conditional messaging (prefers cli for nicer output)
have_cli <- requireNamespace("cli", quietly = TRUE)

msg <- function(...) {
  txt <- sprintf(...)
  if (have_cli) cli::cli_alert_info(txt) else message("[setup] ", txt)
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

# Install a package (CRAN or GitHub). Returns TRUE if available after call.
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

  ok <- tryCatch(
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
      TRUE
    },
    error = function(e) {
      warn("Failed to install %s: %s", target, e$message)
      FALSE
    }
  )

  invisible(ok && requireNamespace(pkg, quietly = TRUE))
}

# Install packages (CRAN and GitHub)
for (pkg in c("ggplot2", "flextable", "cli", "ragg")) {
  ensure_pkg(pkg)
}
for (pkg in c("AAGIThemes", "AAGIPalettes")) {
  ensure_pkg(pkg, github = sprintf("AAGI-AUS/%s", pkg))
}

# ---------------------------------------------------------------------------
# University configuration (SAFE when params missing)
# ---------------------------------------------------------------------------

# params exists during Quarto renders; for presentations you may not have it.
have_params <- exists("params", inherits = TRUE)

uni_code <- if (have_params) params$uni %||% "CU" else "CU"

# uni_info is typically defined in _quarto.yml as a param list; use a safe
# fallback.
uni_info_all <- if (have_params) params$uni_info %||% list() else list()
uni_info <- uni_info_all[[uni_code]] %||% list(name = uni_code)
uni_name <- uni_info$name %||% uni_code

# ---------------------------------------------------------------------------
# Graphics device setup (robust across pdf/docx/html/pptx/revealjs)
# ---------------------------------------------------------------------------

is_latex <- knitr::is_latex_output()
use_ragg <- requireNamespace("ragg", quietly = TRUE)

# For raster outputs, resolution is safe in dev.args.
# Do NOT pass width/height; knitr manages sizing via fig.width/fig.height.
png_dev_args <- list(res = 300)

if (is_latex) {
  # For PDF/LaTeX output:
  # - Prefer base 'pdf' to avoid dev2ext issues across knitr versions
  # - If you *really* want ragg for PDF, do it per-chunk or ensure your
  # knitr supports it
  knitr::opts_chunk$set(dev = "pdf")
  msg("Graphics device: pdf (LaTeX/PDF)")
} else {
  # For everything else (HTML, DOCX, PPTX, revealjs, etc.): PNG is the safest
  # If ragg is installed, it will still be used by some systems when
  # device='png' is backed by ragg/cairo;
  # but we avoid passing a device function that breaks dev2ext().
  knitr::opts_chunk$set(dev = "png", dev.args = png_dev_args)
  msg("Graphics device: png (raster)")
}

# Common knitr defaults (don't override YAML-provided ones unless needed)
knitr::opts_chunk$set(fig.path = "figures/", fig.pos = "H", fig.retina = 2)

# ---------------------------------------------------------------------------
# Load and configure libraries
# ---------------------------------------------------------------------------

try_library("ggplot2")
try_library("AAGIThemes")
try_library("AAGIPalettes")
try_library("flextable")

# Apply ggplot theme if available
if (
  requireNamespace("AAGIThemes", quietly = TRUE) &&
    exists("theme_aagi", where = asNamespace("AAGIThemes"), mode = "function")
) {
  try(ggplot2::theme_set(AAGIThemes::theme_aagi()), silent = TRUE)
  msg("AAGIThemes loaded and ggplot theme applied.")
}

# Configure flextable theme if available
if (
  requireNamespace("flextable", quietly = TRUE) &&
    requireNamespace("AAGIThemes", quietly = TRUE) &&
    exists(
      "theme_ft_aagi",
      where = asNamespace("AAGIThemes"),
      mode = "function"
    )
) {
  try(
    flextable::set_flextable_defaults(theme_fun = AAGIThemes::theme_ft_aagi),
    silent = TRUE
  )
  msg("flextable defaults set to AAGI theme.")
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
