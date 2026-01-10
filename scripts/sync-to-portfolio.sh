#!/bin/bash

# Configuration
PORTFOLIO_CV_DIR="$HOME/developer/personal/portfolio/public/cv"

# Check if portfolio directory exists
if [ ! -d "$PORTFOLIO_CV_DIR" ]; then
    echo "⚠️ Portfolio directory not found at $PORTFOLIO_CV_DIR. Skipping copy."
    exit 0
fi

echo "🚀 Building CVs and syncing to Portfolio..."

# Build CVs (using existing Makefile)
make clean

# Build Public Versions (with \makePublic defined)
echo "Building Public (Stripped) Versions..."

# English
mkdir -p output/en
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output/en "\def\makePublic{1} \input{Bettahar-Samir-Resume.tex}"
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output/en "\def\makePublic{1} \input{Bettahar-Samir-Resume.tex}"

# French
mkdir -p output/fr
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output/fr "\def\makePublic{1} \input{Bettahar-Samir-CV.tex}"
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output/fr "\def\makePublic{1} \input{Bettahar-Samir-CV.tex}"

# Arabic
mkdir -p output/ar
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output/ar "\def\makePublic{1} \input{Bettahar-Samir-Ar-CV.tex}"
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output/ar "\def\makePublic{1} \input{Bettahar-Samir-Ar-CV.tex}"

# Copy files
echo "📂 Copying files to $PORTFOLIO_CV_DIR..."

cp output/en/Bettahar-Samir-Resume.pdf "$PORTFOLIO_CV_DIR/samir-bettahar-cv-en.pdf"
cp output/fr/Bettahar-Samir-CV.pdf "$PORTFOLIO_CV_DIR/samir-bettahar-cv-fr.pdf"
cp output/ar/Bettahar-Samir-Ar-CV.pdf "$PORTFOLIO_CV_DIR/samir-bettahar-cv-ar.pdf"

echo "✅ CVs synced to Portfolio!"
