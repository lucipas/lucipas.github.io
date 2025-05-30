#!/bin/bash

find ./dist -name '*.html' | xargs sed -Ei -f "./sed/antinl.sed"
echo cleaned up uneeded newlines and spaces
