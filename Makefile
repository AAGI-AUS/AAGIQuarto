.PHONY: asset-revealjs asset-docx asset-report asset-short-report assets help
.DEFAULT_GOAL := help

asset-revealjs: ## Render reveal.js Slides
	quarto render docs/demos/template-revealjs.qmd --output-dir assets

asset-docx: ## Render docx report document
	quarto render docs/demos/template-docx-report.qmd --output-dir assets

asset-report: ## Render pdf report document
	quarto render docs/demos/template-pdf-report.qmd --output-dir assets

#asset-short-report: ## Render short pdf document
#	quarto render docs/demos/template-pdf.qmd --output-dir assets

assets:	asset-pdf asset-docx asset-revealjs  ## Render all assets

help:  ## Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-18s\033[0m %s\n", $$1, $$2}'
