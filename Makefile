.PHONY: asset-revealjs asset-docx asset-short-docx asset-report asset-short-report asset-pptx assets help
.DEFAULT_GOAL := help

# Render outputs as part of the docs/ website project so Quarto can discover
# docs/_extensions (including the aagi extension).

asset-revealjs: ## Render reveal.js Slides
	quarto render docs/demos/template-revealjs.qmd --project docs --output-dir docs/assets

asset-docx: ## Render docx report document
	quarto render docs/demos/template-docx-report.qmd --project docs --output-dir docs/assets

asset-short-docx: ## Render short docx report document
	quarto render docs/demos/template-docx-short-report.qmd --project docs --output-dir docs/assets

asset-report: ## Render pdf report document
	quarto render docs/demos/template-pdf-report.qmd --project docs --output-dir docs/assets

asset-short-report: ## Render short pdf report document
	quarto render docs/demos/template-pdf-short-report.qmd --project docs --output-dir docs/assets

asset-pptx: ## Render pptx Slides
	quarto render docs/demos/template-pptx.qmd --project docs --output-dir docs/assets

assets: asset-report asset-short-report asset-docx asset-short-docx asset-revealjs asset-pptx ## Render all assets

help: ## Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-18s\033[0m %s\n", $$1, $$2}'
