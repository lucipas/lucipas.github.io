#!/bin/bash

date +%d%B%Y > ./src/components/lastpub.txt & shuf -n 1 ./src/components/fortune.txt > ./src/components/motd.txt

# PHL => pages
# PRL => directories
rm -rf dist/*
cp -r src/* dist/

# a very convoluted pipeline for the directory pages
# find ./dist -type f | grep -E '\.dir$' | xargs dirname | xargs -I{} find {} | grep -E '\.phl$' | xargs gawk '{print}'

# find all the files in dist that are not transformed and edit in place
echo building fences & find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/fences.sed" 
echo filling in templates & find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/template.sed" 
echo preprocessing &find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/preproc.sed" # some preproc stuff lives here so it should be in front.
echo bbcoding & find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/bbcode.sed" 
echo transforming md elements & find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/md.sed" 
echo translating to html & find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/proc.sed"
echo filling in js & find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/js.sed"
echo escaping hell & find ./dist -name '*.txt' | xargs sed -Ei -f "./sed/ansiESC.sed"
# find all .xpl files and change it's ext to html
echo mv *.phl to *.html & find ./dist -name '*.phl' | sed -E "s/(.+)\.phl/mv \1.phl \1.html/" | bash
# remove compnents folder from dist
echo rm -rf dist/components & rm -rf dist/components
# validate that no loinks are broken, accessiblity rules are enforced, etc.
# build rss
# stats

find ./dist -type f | gawk 'BEGIN {tot=htc=csc=imc=0}; /\.html/{htc += 1}; /\.css/{csc += 1};/(\.png|\.gif|\.jpeg)/{imc += 1};/.+/{tot+=1};END{print "# site analysis\n- " htc " html file.\n- " csc " css files.\n- " imc " image files.\n- " tot " total files"}' | tee README.MD
cp -r ./src/.well-known/ ./dist/
# add prev and next to blogs

