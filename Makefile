# Awesome CV Makefile
# Builds French and English versions to separate output folders

LATEX = xelatex
LATEXFLAGS = -interaction=nonstopmode -halt-on-error

# Source files
CV_FR = Bettahar-Samir-CV.tex
CV_EN = Bettahar-Samir-Resume.tex
CV_AR = Bettahar-Samir-Ar-CV.tex

# Output directories
OUT_DIR = output
OUT_FR = $(OUT_DIR)/fr
OUT_EN = $(OUT_DIR)/en
OUT_AR = $(OUT_DIR)/ar

# Output filenames
PDF_FR = $(OUT_FR)/Bettahar-Samir-CV.pdf
PDF_EN = $(OUT_EN)/Bettahar-Samir-Resume.pdf
PDF_AR = $(OUT_AR)/Bettahar-Samir-Ar-CV.pdf

.PHONY: all fr en ar clean help

all: fr en ar
	@echo "✓ All CVs built successfully"

fr: $(PDF_FR)
	@echo "✓ French CV built: $(PDF_FR)"

en: $(PDF_EN)
	@echo "✓ English CV built: $(PDF_EN)"

ar: $(PDF_AR)
	@echo "✓ Arabic CV built: $(PDF_AR)"

$(PDF_FR): $(CV_FR) awesome-cv.cls sections/fr/*.tex
	@mkdir -p $(OUT_FR)
	$(LATEX) $(LATEXFLAGS) -output-directory=$(OUT_FR) $(CV_FR)
	$(LATEX) $(LATEXFLAGS) -output-directory=$(OUT_FR) $(CV_FR)

$(PDF_EN): $(CV_EN) awesome-cv.cls sections/en/*.tex
	@mkdir -p $(OUT_EN)
	$(LATEX) $(LATEXFLAGS) -output-directory=$(OUT_EN) $(CV_EN)
	$(LATEX) $(LATEXFLAGS) -output-directory=$(OUT_EN) $(CV_EN)

$(PDF_AR): $(CV_AR) awesome-cv.cls sections/ar/*.tex
	@mkdir -p $(OUT_AR)
	$(LATEX) $(LATEXFLAGS) -output-directory=$(OUT_AR) $(CV_AR)
	$(LATEX) $(LATEXFLAGS) -output-directory=$(OUT_AR) $(CV_AR)

clean:
	@rm -rf $(OUT_DIR)
	@rm -f *.aux *.log *.out *.fls *.fdb_latexmk *.synctex.gz
	@echo "✓ Cleaned all build artifacts"

help:
	@echo "Available targets:"
	@echo "  make all   - Build all CV versions"
	@echo "  make fr    - Build French CV only"
	@echo "  make en    - Build English CV only"
	@echo "  make ar    - Build Arabic CV only"
	@echo "  make clean - Remove all generated files"
