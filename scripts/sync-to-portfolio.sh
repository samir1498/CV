#!/bin/bash

PORTFOLIO_CV_DIR="$HOME/developer/personal/portfolio/public/cv"

if [ ! -d "$PORTFOLIO_CV_DIR" ]; then
    echo "⚠️ Portfolio directory not found at $PORTFOLIO_CV_DIR. Skipping copy."
    exit 0
fi

echo "🚀 Building public CVs and syncing to Portfolio..."

make clean
make public

echo "📂 Copying files to $PORTFOLIO_CV_DIR..."

cp output/en/Bettahar-Samir-Resume.pdf "$PORTFOLIO_CV_DIR/samir-bettahar-cv-en.pdf"
cp output/fr/Bettahar-Samir-CV.pdf "$PORTFOLIO_CV_DIR/samir-bettahar-cv-fr.pdf"
cp output/ar/Bettahar-Samir-Ar-CV.pdf "$PORTFOLIO_CV_DIR/samir-bettahar-cv-ar.pdf"

echo "✅ CVs synced to Portfolio!"
