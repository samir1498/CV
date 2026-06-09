LATEX = xelatex
LATEXFLAGS = -interaction=nonstopmode -halt-on-error

CV_FR = Bettahar-Samir-CV.tex
CV_EN = Bettahar-Samir-Resume.tex
CV_AR = Bettahar-Samir-Ar-CV.tex

OUT_DIR = output
OUT_FR = $(OUT_DIR)/fr
OUT_EN = $(OUT_DIR)/en
OUT_AR = $(OUT_DIR)/ar

PDF_FR = $(OUT_FR)/Bettahar-Samir-CV.pdf
PDF_EN = $(OUT_EN)/Bettahar-Samir-Resume.pdf
PDF_AR = $(OUT_AR)/Bettahar-Samir-Ar-CV.pdf
PRIVATE_VARS = private-vars.tex

PRIVATE ?= 0

.PHONY: all public private check-private-vars fr en ar clean release help

all: public

public: PRIVATE=0
public: fr en ar
	@echo "✓ Public CVs built successfully"

private: PRIVATE=1
private: check-private-vars fr en ar
	@echo "✓ Private CVs built successfully"

check-private-vars:
	@if [ ! -f "$(PRIVATE_VARS)" ]; then \
		echo "Missing $(PRIVATE_VARS). Copy private-vars.example.tex to $(PRIVATE_VARS) and set private values."; \
		exit 1; \
	fi

fr:
	@mkdir -p $(OUT_FR)
	@if [ "$(PRIVATE)" = "1" ]; then \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-CV -output-directory=$(OUT_FR) "\\def\\isprivatecv{1}\\input{$(CV_FR)}"; \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-CV -output-directory=$(OUT_FR) "\\def\\isprivatecv{1}\\input{$(CV_FR)}"; \
	else \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-CV -output-directory=$(OUT_FR) $(CV_FR); \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-CV -output-directory=$(OUT_FR) $(CV_FR); \
	fi
	@echo "✓ French CV built: $(PDF_FR)"

en:
	@mkdir -p $(OUT_EN)
	@if [ "$(PRIVATE)" = "1" ]; then \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-Resume -output-directory=$(OUT_EN) "\\def\\isprivatecv{1}\\input{$(CV_EN)}"; \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-Resume -output-directory=$(OUT_EN) "\\def\\isprivatecv{1}\\input{$(CV_EN)}"; \
	else \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-Resume -output-directory=$(OUT_EN) $(CV_EN); \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-Resume -output-directory=$(OUT_EN) $(CV_EN); \
	fi
	@echo "✓ English CV built: $(PDF_EN)"

ar:
	@mkdir -p $(OUT_AR)
	@if [ "$(PRIVATE)" = "1" ]; then \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-Ar-CV -output-directory=$(OUT_AR) "\\def\\isprivatecv{1}\\input{$(CV_AR)}"; \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-Ar-CV -output-directory=$(OUT_AR) "\\def\\isprivatecv{1}\\input{$(CV_AR)}"; \
	else \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-Ar-CV -output-directory=$(OUT_AR) $(CV_AR); \
		$(LATEX) $(LATEXFLAGS) -jobname=Bettahar-Samir-Ar-CV -output-directory=$(OUT_AR) $(CV_AR); \
	fi
	@echo "✓ Arabic CV built: $(PDF_AR)"

release: public
	@echo "🚀 Creating GitHub release..."
	@LATEST=$$(gh release list --repo samir1498/CV --limit 1 --json tagName --jq '.[0].tagName' 2>/dev/null || echo "v0.0.0"); \
	echo "  Latest tag: $$LATEST"; \
	NEW_VERSION=$$(echo "$$LATEST" | awk -F. -v OFS=. '{$$NF++;print}'); \
	read -p "  Enter version [$$NEW_VERSION]: " VERSION; \
	VERSION=$${VERSION:-$$NEW_VERSION}; \
	echo "  Creating release $$VERSION..."; \
	gh release create "$$VERSION" \
		--repo samir1498/CV \
		--title "$$VERSION" \
		--generate-notes \
		$(PDF_FR)#"CV (FR)" \
		$(PDF_EN)#"CV (EN)" \
		$(PDF_AR)#"CV (AR)"; \
	echo "✓ Release $$VERSION created successfully"

clean:
	@rm -rf $(OUT_DIR)
	@find . -maxdepth 2 -type f \( -name "*.aux" -o -name "*.log" -o -name "*.out" -o -name "*.fls" -o -name "*.fdb_latexmk" -o -name "*.synctex.gz" \) -delete 2>/dev/null || true
	@echo "✓ Cleaned all build artifacts"

help:
	@echo "Available targets:"
	@echo "  make public  - Build public CV set (default)"
	@echo "  make private - Build private CV set (shows phone/address/photo)"
	@echo "                 requires private-vars.tex (copy from private-vars.example.tex)"
	@echo "  make fr      - Build French CV only"
	@echo "  make en      - Build English CV only"
	@echo "  make ar      - Build Arabic CV only"
	@echo "  make release - Build public CVs and create a GitHub Release with the PDFs"
	@echo "  make clean   - Remove all generated files"