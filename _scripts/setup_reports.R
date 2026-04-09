# _scripts/setup_reports.R
# Centralized setup for AAGIQuarto template docs.
# Source this in the first code chunk of each document:
#   source("_scripts/setup_reports.R", local = TRUE)

`%||%` <- function(a, b) if (!is.null(a)) a else b

# Ensure params exists
if (!exists("params")) {
  stop("[setup_reports] 'params' not found. Source this script from a rendering context where 'params' exists.")
}

# Compute uni_name from params$uni_info if present (fallback small mapping)
uni_code <- params$uni %||% "CU"
if (!is.null(params$uni_info) && !is.null(params$uni_info[[uni_code]])) {
  uni_name <- params$uni_info[[uni_code]]$name %||% uni_code
} else {
  uni_name <- switch(uni_code,
    CU = "Curtin University",
    AU = "University of Adelaide",
    UQ = "University of Queensland",
    ANU = "Australian National University",
    uni_code
  )
}

# AAGI email: require explicit provision
env_email <- Sys.getenv("AAGI_EMAIL", unset = "")
doc_email <- if (!is.null(params$aagi_email)) params$aagi_email else NULL

aagi_email <- if (nzchar(env_email)) {
  env_email
} else if (!is.null(doc_email) && nzchar(doc_email)) {
  doc_email
} else {
  stop(
    paste0(
      "[setup_reports] AAGI contact email not provided. Provide either:\n",
      "  - environment variable AAGI_EMAIL (e.g. export AAGI_EMAIL='name@org.edu')\n",
      "  - document YAML param params$aagi_email: 'name@org.edu'\n\n",
      "Example YAML:\n",
      "params:\n",
      "  aagi_email: \"contact@institution.edu\"\n"
    ),
    call. = FALSE
  )
}

# Export for child includes and inline R
assign("uni_name", uni_name, envir = knitr::knit_global())
assign("aagi_email", aagi_email, envir = knitr::knit_global())

message("[setup_reports] exported uni_name=", uni_name, " aagi_email=", aagi_email)
