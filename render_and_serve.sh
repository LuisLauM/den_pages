#!/bin/bash
rm resources public -r
quarto render 
hugo server --disableFastRender
