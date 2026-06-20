.PHONY: \
	asset-revealjs asset-docx asset-short-docx asset-report asset-short-report \
	asset-pptx asset-html asset-short-html assets help check-docs install-extension
.DEFAULT_GOAL := help
DOCS_DIR    ?= docs
ASSET_DIR   ?= assets
EXTENSION_SRC ?= _extensions/aagi

fonts:
	mkdir -p $(DOCS_DIR)/assets/fonts
	cp $(DOCS_DIR)/_extensions/AAGI-AUS/aagi/assets/fonts/*.woff2 $(DOCS_DIR)/assets/fonts/

check-docs:
	@test -d "$(DOCS_DIR)" || { \
	  echo "Error: '$(DOCS_DIR)/' directory not found."; \
	  echo "Run make from the repository root or set DOCS_DIR=/path/to/docs"; \
	  exit 1; }

install-extension: check-docs ## Install the committed AAGI extension into $(DOCS_DIR)
	mkdir -p $(DOCS_DIR)/_extensions/AAGI-AUS/aagi
	cp -r $(EXTENSION_SRC)/. $(DOCS_DIR)/_extensions/AAGI-AUS/aagi/

asset-revealjs: check-docs install-extension fonts ## Render reveal.js slides into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-revealjs.qmd" || { echo "Error: $(DOCS_DIR)/template-revealjs.qmd not found"; exit 1; }
	mkdir -p $(DOCS_DIR)/$(ASSET_DIR)
	cd $(DOCS_DIR) && quarto render template-revealjs.qmd --to "AAGI-AUS/aagi-revealjs"
	mv $(DOCS_DIR)/template-revealjs.html $(DOCS_DIR)/$(ASSET_DIR)/

asset-docx: check-docs install-extension fonts ## Render docx report into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-docx-report.qmd" || { echo "Error: $(DOCS_DIR)/template-docx-report.qmd not found"; exit 1; }
	mkdir -p $(DOCS_DIR)/$(ASSET_DIR)
	cd $(DOCS_DIR) && quarto render template-docx-report.qmd --to "AAGI-AUS/aagi-docx+report"
	mv $(DOCS_DIR)/template-docx-report.docx $(DOCS_DIR)/$(ASSET_DIR)/

asset-short-docx: check-docs install-extension fonts ## Render short docx report into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-docx-short-report.qmd" || { echo "Error: $(DOCS_DIR)/template-docx-short-report.qmd not found"; exit 1; }
	mkdir -p $(DOCS_DIR)/$(ASSET_DIR)
	cd $(DOCS_DIR) && quarto render template-docx-short-report.qmd --to "AAGI-AUS/aagi-docx+shortreport"
	mv $(DOCS_DIR)/template-docx-short-report.docx $(DOCS_DIR)/$(ASSET_DIR)/

asset-report: check-docs install-extension fonts ## Render PDF report into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-pdf-report.qmd" || { echo "Error: $(DOCS_DIR)/template-pdf-report.qmd not found"; exit 1; }
	mkdir -p $(DOCS_DIR)/$(ASSET_DIR)
	cd $(DOCS_DIR) && quarto render template-pdf-report.qmd --to "AAGI-AUS/aagi-pdf+report"
	mv $(DOCS_DIR)/template-pdf-report*.pdf $(DOCS_DIR)/$(ASSET_DIR)/

asset-short-report: check-docs install-extension fonts ## Render short PDF report into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-pdf-short-report.qmd" || { echo "Error: $(DOCS_DIR)/template-pdf-short-report.qmd not found"; exit 1; }
	mkdir -p $(DOCS_DIR)/$(ASSET_DIR)
	cd $(DOCS_DIR) && quarto render template-pdf-short-report.qmd --to "AAGI-AUS/aagi-pdf+shortreport"
	mv $(DOCS_DIR)/template-pdf-short-report*.pdf $(DOCS_DIR)/$(ASSET_DIR)/

asset-pptx: check-docs install-extension fonts ## Render pptx slides into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-pptx.qmd" || { echo "Error: $(DOCS_DIR)/template-pptx.qmd not found"; exit 1; }
	mkdir -p $(DOCS_DIR)/$(ASSET_DIR)
	cd $(DOCS_DIR) && quarto render template-pptx.qmd --to "AAGI-AUS/aagi-pptx"
	mv $(DOCS_DIR)/template-pptx.pptx $(DOCS_DIR)/$(ASSET_DIR)/

asset-html: check-docs install-extension fonts ## Render HTML report into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-html-report.qmd" || { echo "Error: $(DOCS_DIR)/template-html-report.qmd not found"; exit 1; }
	mkdir -p $(DOCS_DIR)/$(ASSET_DIR)
	cd $(DOCS_DIR) && quarto render template-html-report.qmd --to "AAGI-AUS/aagi-html+report"
	mv $(DOCS_DIR)/template-html-report.html $(DOCS_DIR)/$(ASSET_DIR)/

asset-short-html: check-docs install-extension fonts ## Render short HTML report into $(DOCS_DIR)/$(ASSET_DIR)
	@test -f "$(DOCS_DIR)/template-html-short-report.qmd" || { echo "Error: $(DOCS_DIR)/template-html-short-report.qmd not found"; exit 1; }
	mkdir -p $(DOCS_DIR)/$(ASSET_DIR)
	cd $(DOCS_DIR) && quarto render template-html-short-report.qmd --to "AAGI-AUS/aagi-html+shortreport"
	mv $(DOCS_DIR)/template-html-short-report.html $(DOCS_DIR)/$(ASSET_DIR)/

assets: install-extension fonts asset-report asset-short-report asset-docx asset-short-docx asset-html asset-short-html asset-revealjs asset-pptx ## Render all assets

help: ## Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-18s\033[0m %s\n", $$1, $$2}'
