#!/usr/bin/env sh

cd $(dirname "$0")

set -ev

Rscript \
  -e "bookdown::render_book('00-index.Rmd', 'bookdown::gitbook')" \
  -e "bookdown::render_book('00-index.Rmd', 'bookdown::pdf_book')" \
  -e "bookdown::render_book('00-index.Rmd', 'bookdown::epub_book')"

#Rscript -e "bookdown::render_book('00-index.Rmd', 'bookdown::tufte_html_book')"
