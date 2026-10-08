# AAGI Quarto setup (reports)
# - Optional auto-install via pak/CRAN (controlled by AAGI_AUTO_INSTALL)
# - Safe when params are missing (presentations etc.)
# - Avoids knitr device width/height duplication (do NOT pass width/height in
#   dev.args)

allow_install <- isTRUE(as.logical(Sys.getenv(
  "AAGI_AUTO_INSTALL",
  unset = interactive()
)))

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
# PDF font resolution (shared contract with AAGIThemes via AAGI_MAINFONT)
# ---------------------------------------------------------------------------

# Returns TRUE if `family` is installed. Uses systemfonts when available, else
# fc-list (not on Windows). `length(out) > 0` is required: fc-list returns
# character(0) when nothing matches.
font_available <- function(family) {
  if (requireNamespace("systemfonts", quietly = TRUE)) {
    fams <- tryCatch(systemfonts::system_fonts()$family, error = function(e) NULL)
    if (!is.null(fams)) {
      return(tolower(family) %in% tolower(fams))
    }
  }
  if (.Platform$OS.type != "windows" && nzchar(Sys.which("fc-list"))) {
    out <- tryCatch(
      suppressWarnings(system2(
        "fc-list",
        shQuote(family),
        stdout = TRUE,
        stderr = FALSE
      )),
      error = function(e) character(0)
    )
    return(length(out) > 0 && any(nzchar(out)))
  }
  FALSE
}

# Resolve the font and export it as AAGI_MAINFONT. An existing value is
# respected. Order: Proxima Nova, Arial, TeX Gyre Heros (never "sans": XeLaTeX
# cannot resolve it). Mirrors the \IfFontExistsTF order in the PDF templates.
set_aagi_mainfont <- function() {
  current <- Sys.getenv("AAGI_MAINFONT", unset = "")
  if (nzchar(current)) {
    return(invisible(current))
  }
  chosen <- "TeX Gyre Heros"
  for (f in c("Proxima Nova", "Arial")) {
    if (font_available(f)) {
      chosen <- f
      break
    }
  }
  Sys.setenv(AAGI_MAINFONT = chosen)
  invisible(chosen)
}

set_aagi_mainfont()

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

if (is_latex) {
  # PDF: use pdf device
  knitr::opts_chunk$set(dev = "pdf")
  msg("Graphics device: pdf")
} else {
  # Everything else: png only, minimal config
  knitr::opts_chunk$set(dev = "png")
  msg("Graphics device: png")
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

# Configure flextable theme
if (
  requireNamespace("flextable", quietly = TRUE) &&
    requireNamespace("AAGIThemes", quietly = TRUE) &&
    exists(
      "theme_ft_aagi",
      where = asNamespace("AAGIThemes"),
      mode = "function"
    )
) {
  cli::cli_inform("flextable available; using per-table theming.")
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
