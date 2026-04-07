.PHONY: asset-revealjs asset-docx asset-short-docx asset-report asset-short-report asset-pptx assets help
.DEFAULT_GOAL := help

asset-revealjs: ## Render reveal.js Slides (AAGI theme)
	cd docs && quarto render template-revealjs.qmd --to revealjs --output-dir assets

asset-docx: ## Render docx report document
	cd docs && quarto render template-docx-report.qmd --to docx+report --output-dir assets

asset-short-docx: ## Render short docx report document
	cd docs && quarto render template-docx-short-report.qmd --to docx+short+report --output-dir assets

asset-report: ## Render pdf report document
	cd docs && quarto render template-pdf-report.qmd --to pdf+report --output-dir assets

asset-short-report: ## Render short pdf report document
	cd docs && quarto render template-pdf-short-report.qmd --to pdf+short+report --output-dir assets

asset-pptx: ## Render pptx Slides
	cd docs && quarto render template-pptx.qmd --to pptx --output-dir assets

asset-html: ## Render HTML report document
	cd docs && quarto render template-html-report.qmd --to html+report --output-dir assets

asset-short-html: ## Render short HTML report document
	cd docs && quarto render template-html-short-report.qmd --to html+short+report --output-dir assets

assets: asset-report asset-short-report asset-docx asset-short-docx asset-html asset-short-html asset-revealjs asset-pptx ## Render all assets

help: ## Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-18s\033[0m %s\n", $$1, $$2}'
