#!/bin/bash

# check if gawk.heap exists in path first.
if [ -f "./gawk.heap" ];
then
    export GAWK_PERSIST_FILE=gawk.heap
fi

date +%d%B%Y > ./src/components/lastpub.txt
shuf -n 1 ./src/components/fortune.txt > ./src/components/motd.txt

usage(){
    echo "build [-sv]"
    echo "A utility to build phl projects"
    echo "-s                 enables linting"
    echo "-v                 verbose"
    echo "--phl=[EXT]        changes phl extension from phl to EXT"
}

# PHL => pages
# PRL => directories
rm -rf dist/*
cp -r src/* dist/

# a very convoluted pipeline for the directory pages
# find ./dist -type f | grep -E '\.dir$' | xargs dirname | xargs -I{} find {} | grep -E '\.phl$' | xargs gawk '{print}'

# find all the files in dist that are not transformed and edit in place
echo transforming md elements
find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/md.sed" 
echo filling in templates
find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/template.sed" 
echo preprocessing
find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/preproc.sed" # some preproc stuff lives here so it should be in front.
echo translating to html
find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/proc.sed"
echo filling in js
find ./dist -name '*.phl' | xargs sed -Ei -f "./sed/js.sed"
# find all .xpl files and change it's ext to html
echo mv *.phl to *.html
find ./dist -name '*.phl' | sed -E "s/(.+)\.phl/mv \1.phl \1.html/" | bash
# remove compnents folder from dist
echo rm -rf dist/components
rm -rf dist/components
# validate that no loinks are broken, accessiblity rules are enforced, etc.
# build rss
# stats

if [ -f "./gawk.heap" ]
then
    echo "Using GAWK's persistent memory for analysis"
    find ./dist | gawk 'BEGIN {htc=csc=imc=0}; /\.html/{htc += 1}; /\.css/{csc += 1};/(\.png|\.gif|\.jpeg)/{imc += 1};END{print "# site analysis\n- " htc " html files. Delta of " htc-thtc "\n- " csc " css files. Delta of " csc -tsc "\n- " imc " image files. Delta of " imc - timc ;thtc = htc; tsc = csc; timc = imc}' | tee README.MD
    unset GAWK_PERSIST_FILE
else
    echo "Not using GAWK's persistent memory for analysis"
    find ./dist -type f | gawk 'BEGIN {htc=csc=imc=0}; /\.html/{htc += 1}; /\.css/{csc += 1};/(\.png|\.gif|\.jpeg)/{imc += 1};END{print "# site analysis\n- " htc " html file.\n- " csc " css files.\n- " imc " image files."}' | tee README.MD
    echo "- $(find ./dist -type f | wc -l) total files" | tee -a ./README.MD
fi

# add prev and next to blogs

