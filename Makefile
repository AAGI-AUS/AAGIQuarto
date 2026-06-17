.PHONY: \
	asset-revealjs asset-docx asset-short-docx asset-report asset-short-report \
	asset-pptx asset-html asset-short-html assets help check-docs
.DEFAULT_GOAL := help

DOCS_DIR ?= docs
ASSET_DIR ?= assets

fonts:
	mkdir -p docs/assets/fonts
	cp _extensions/aagi/assets/fonts/*.woff2 docs/assets/fonts/

check-docs:
	@test -d "$(DOCS_DIR)" || { echo "Error: '$(DOCS_DIR)/' directory not found. Run make from the repository root or set DOCS_DIR=/path/to/docs"; exit 1; }

asset-revealjs: check-docs ## Render reveal.js slides into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-revealjs.qmd" || { echo "Error: $(DOCS_DIR)/template-revealjs.qmd not found"; exit 1; }
	cd $(DOCS_DIR) && quarto render template-revealjs.qmd --to revealjs --output-dir $(ASSET_DIR)

asset-docx: check-docs ## Render docx report document into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-docx-report.qmd" || { echo "Error: $(DOCS_DIR)/template-docx-report.qmd not found"; exit 1; }
	cd $(DOCS_DIR) && quarto render template-docx-report.qmd --to docx+report --output-dir $(ASSET_DIR)

asset-short-docx: check-docs ## Render short docx report document into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-docx-short-report.qmd" || { echo "Error: $(DOCS_DIR)/template-docx-short-report.qmd not found"; exit 1; }
	cd $(DOCS_DIR) && quarto render template-docx-short-report.qmd --to docx+short+report --output-dir $(ASSET_DIR)

asset-report: check-docs ## Render pdf report document into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-pdf-report.qmd" || { echo "Error: $(DOCS_DIR)/template-pdf-report.qmd not found"; exit 1; }
	cd $(DOCS_DIR) && quarto render template-pdf-report.qmd --to pdf+report --output-dir $(ASSET_DIR)

asset-short-report: check-docs ## Render short pdf report document into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-pdf-short-report.qmd" || { echo "Error: $(DOCS_DIR)/template-pdf-short-report.qmd not found"; exit 1; }
	cd $(DOCS_DIR) && quarto render template-pdf-short-report.qmd --to pdf+short+report --output-dir $(ASSET_DIR)

asset-pptx: check-docs ## Render pptx slides into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-pptx.qmd" || { echo "Error: $(DOCS_DIR)/template-pptx.qmd not found. Add that file before using asset-pptx."; exit 1; }
	cd $(DOCS_DIR) && quarto render template-pptx.qmd --to pptx --output-dir $(ASSET_DIR)

asset-html: check-docs ## Render HTML report document into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-html-report.qmd" || { echo "Error: $(DOCS_DIR)/template-html-report.qmd not found"; exit 1; }
	cd $(DOCS_DIR) && quarto render template-html-report.qmd --to html+report --output-dir $(ASSET_DIR)

asset-short-html: check-docs ## Render short HTML report document into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-html-short-report.qmd" || { echo "Error: $(DOCS_DIR)/template-html-short-report.qmd not found"; exit 1; }
	cd $(DOCS_DIR) && quarto render template-html-short-report.qmd --to html+short+report --output-dir $(ASSET_DIR)

# Note: --output-dir $(ASSET_DIR) is relative to $(DOCS_DIR), so outputs land in $(DOCS_DIR)/$(ASSET_DIR).
assets: asset-report asset-short-report asset-docx asset-short-docx asset-html asset-short-html asset-revealjs ## Render all assets except pptx (template-pptx.qmd is optional)

help: ## Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-18s\033[0m %s\n", $$1, $$2}'
