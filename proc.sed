#!/bin/sed -E
#           ^ we use extend regexes in this family
#
# this script is used for base html tags.
# There will be no css dependent tags in this script.


s/###### (.+)/<h6>\1<\/h6>/
s/##### (.+)/<h5>\1<\/h5>/
s/#### (.+)/<h4>\1<\/h4>/
s/### (.+)/<h3>\1<\/h3>/
s/## (.+)/<h2>\1<\/h2>/
s/# (.+)/<h1>\1<\/h1>/
s/\.hr/<hr \/>/
s/!\[([A-Za-z0-9 l k ]+)\]\(([A-Za-z\/.:]+)\)/<img src="\2" alt="\1" \/>/
s/\[([A-Za-z.0-9 ]+)\]\(([A-Za-z\/.:]+)\)/<a href="\2">\1<\/a>/
s/\.eul/<\/ul>/
s/\.eol/<\/ol>/
s/\.ul/<ul>/
s/\.ol/<ol>/
s/\.li (.+)/<li>\1<\/li>/
s/\.head (.+)/<!DOCTYPE html>\n<html dir="ltr" lang="en">\n<head>\n\t<title>\1<\/title>/
s/\.tbl/<table>/
s/\.etbl/<\/table>/
s/\.tr/<tr>/
s/\.etr/<\/tr>/
s/\.td (.+)/<td>\1<\/td>/
s/\.ep/<\/p>/g
s/\.p/<p>/g
s/\.desc (.+)/<meta name="description" content="\1">/
s/ \.esp/<\/span>/
s/\.sp (.+)/<span>\1/
# assume that where head ends your body begins
s/\.ehead/<\/head>\n<body>/
s/\.ebody/<\/body><\/html>/
s/\.d (.+)/<div>\1<\/div>/
s/\.bd/<div>/
s/\.ed/<\/div>/
s/\.cmt (.+)/<!-- \1 -->/
s/\.ref ([0-9]+)/<meta http-equiv="refresh" content="\1">/
s/\.vp/<meta name="viewport" content="width=device-width, initial-scale=1.0">/
s/\.n/<nav>/
s/\.en/<\/nav>/
s/\.ft/<footer>/
s/\.eft/<\/footer>/
s/\.br/<\/br>/
s/\.css (.+)/<link href="\1" type="text\/css" rel="stylesheet"\/>/
s/\.utf8/<meta charset="utf-8">/
