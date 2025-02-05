#!/bin/bash

set -e  # Stop if error

echo "Updating packages and dependencies"
sudo apt-get update && sudo apt-get install -y wget r-base libcurl4-openssl-dev libssl-dev libxml2-dev

# Hugo install
HUGO_VERSION="0.142.0"
wget -O hugo.deb "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb"
sudo dpkg -i hugo.deb

# Clone Git modules
git submodule update --init --recursive

# Installing required R packages
Rscript -e 'install.packages("renv", repos="https://cran.rstudio.com/")'
Rscript -e 'renv::restore(prompt = FALSE)'

# Run R script for creating md files
Rscript R/mdGenerator.R --vanilla

# Installing Quarto
wget -qO- https://quarto.org/download/latest/quarto-linux-amd64.deb > quarto.deb
sudo dpkg -i quarto.deb

# Render with Quarto
quarto render static/manualsguides

# Build with Hugo
hugo --gc --minify --baseURL "${CF_PAGES_URL:-https://default-url.com}"
