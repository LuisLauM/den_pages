#!/bin/bash
rm resources public -r

quarto render static/manualsguides

hugo --cleanDestinationDir --gc --minify
# hugo server --disableFastRender

cp -r _site/static/manualsguides/* public/manualsguides/
mkdir -p public/site_libs/ && cp -r _site/site_libs/* public/site_libs/

cd public && python -m http.server 8080

