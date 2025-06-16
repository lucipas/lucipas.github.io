#!/bin/sed -E
#           ^ we use extend regexes in this family
#
# this script is used for base html tags.
# There will be no css dependent tags in this script.

# Lines that are not escaped
# meaning beginning of the line and a []
/^\s*\|\|/!{
	/<code>/,/<\/code>/!{
	s/@hr/<hr \/>/
	s/@eul/<\/ul>/
	s/@eol/<\/ol>/
	s/@ul/<ul>/
	s/@ol/<ol>/
	s/@li (.+)/<li>\1<\/li>/
	s/@head (.+)/<!DOCTYPE html>\n<html dir="ltr" lang="en">\n<head>\n\t<title>\1<\/title>/
	s/@tbl/<table>/
	s/@etbl/<\/table>/
	s/@tr/<tr>/
	s/@etr/<\/tr>/
	s/@td (.+)/<td>\1<\/td>/
	s/@ep/<\/p>/
	s/@p/<p>/
	s/@desc (.+)/<meta name="description" content="\1">/
	s/@esp/<\/span>/
	s/@sp (.+)/<span>\1/
	# assume that where head ends your body begins
	s/@ehead/<\/head>\n<body>/
	s/@ebody/<\/body><\/html>/
	s/@d (.+)/<div>\1<\/div>/
	s/@bd/<div>/
	s/@ed/<\/div>/
	s/@cmt (.+)/<!-- \1 -->/
	s/@ref ([0-9]+)/<meta http-equiv="refresh" content="\1">/
	s/@vp/<meta name="viewport" content="width=device-width, initial-scale=1.0">/
	s/@n/<nav>/
	s/@en/<\/nav>/
	s/@ft/<footer>/
	s/@eft/<\/footer>/
	s/@br/<\/br>/
	s/@css (.+)/<link href="\1" type="text\/css" rel="stylesheet"\/>/
	s/@utf8/<meta charset="utf-8">/
	s/@favi (.+)/<link rel="icon" type="image\/x-icon" href="\1">/
	s/@favipng (.+)/<link rel="icon" type="image\/png" href="\1">/
	s/@js (.+)/<script src="\1"><\/script>/
	s/@h6 (.+)/<h6>\1<\/h6>/
	s/@h5 (.+)/<h5>\1<\/h5>/
	s/@h4 (.+)/<h4>\1<\/h4>/
	s/@h3 (.+)/<h3>\1<\/h3>/
	s/@h2 (.+)/<h2>\1<\/h2>/
	s/@h1 (.+)/<h1>\1<\/h1>/
	
}
}
