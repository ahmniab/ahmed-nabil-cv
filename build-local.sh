#!/bin/bash

# Local CV Build Script
# Usage: ./build-local.sh
# This script compiles the CV locally and shows build status

set -e

echo "================================"
echo "🔨 CV Compilation Test Script"
echo "================================"
echo ""

# Check if pdflatex is installed
if ! command -v pdflatex &> /dev/null; then
    echo "❌ pdflatex not found!"
    echo ""
    echo "Install TeX Live:"
    echo "  Ubuntu/Debian: sudo apt-get install texlive-latex-base texlive-fonts-recommended texlive-xetex"
    echo "  macOS: brew install basictex  (then add /Library/TeX/texbin to PATH)"
    echo "  Fedora: sudo dnf install texlive-scheme-basic texlive-fontawesome5"
    exit 1
fi

echo "✅ pdflatex found"
echo ""

# Clean up old artifacts
echo "🧹 Cleaning old build artifacts..."
rm -f *.aux *.log *.out *.fls *.fdb_latexmk *.synctex.gz
echo ""

# First compilation pass
echo "📝 First compilation pass (collecting references)..."
if pdflatex -interaction=nonstopmode -file-line-error -jobname=ahmed-nabil-resume main.tex > /dev/null 2>&1; then
    echo "✅ First pass successful"
else
    echo "❌ First pass failed"
    echo ""
    echo "Showing compilation errors:"
    pdflatex -interaction=nonstopmode -file-line-error -jobname=ahmed-nabil-resume main.tex | grep -A 5 "Error\|error\|!" || true
    exit 1
fi

echo ""

# Second compilation pass
echo "📝 Second compilation pass (resolving references)..."
if pdflatex -interaction=nonstopmode -file-line-error -jobname=ahmed-nabil-resume main.tex > /dev/null 2>&1; then
    echo "✅ Second pass successful"
else
    echo "❌ Second pass failed"
    exit 1
fi

echo ""

# Check if PDF was generated
if [ -f ahmed-nabil-resume.pdf ]; then
    pdf_size=$(du -h ahmed-nabil-resume.pdf | cut -f1)
    echo "✅ PDF generated successfully!"
    echo "   Size: $pdf_size"
    echo "   Location: ahmed-nabil-resume.pdf"
    echo ""
    echo "================================"
    echo "🎉 Build successful!"
    echo "================================"
    echo ""
    echo "Ready to push to GitHub:"
    echo "  git add ."
    echo "  git commit -m 'Update CV'"
    echo "  git push origin main"
else
    echo "❌ PDF generation failed - file not found"
    exit 1
fi

# Show page count
if command -v pdfinfo &> /dev/null; then
    pages=$(pdfinfo ahmed-nabil-resume.pdf | grep Pages | awk '{print $2}')
    echo "📄 Pages: $pages"
fi

echo ""
