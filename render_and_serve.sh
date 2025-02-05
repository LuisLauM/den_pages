#!/bin/bash
rm resources public -r
# Rscript R/mdGenerator.R --vanilla
quarto render 
hugo --cleanDestinationDir --gc
hugo server --disableFastRender
