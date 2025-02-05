#!/bin/bash
rm resources public -r

Rscript R/mdGenerator.R --vanilla

hugo --cleanDestinationDir --gc --minify

# quarto render static/manualsguides
# cp -r _site/static/manualsguides/* public/manualsguides/
# cp -r _site/site_libs/* ./
 
# cd public && python -m http.server 8080

