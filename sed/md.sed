#!/bin/sed -Ef

### md-to-html: Sed script that converts Markdown to HTML code
# from https://github.com/moltenib/md-to-html


/^\s*\[\]/!{
	s/#{6} (.*)$/<h6 id="\1">\1<\/h6>/
	s/#{5} (.*)$/<h5 id="\1">\1<\/h5>/
	s/#{4} (.*)$/<h4 id="\1">\1<\/h4>/
	s/#{3} (.*)$/<h3 id="\1">\1<\/h3>/
	s/#{2} (.*)$/<h2 id="\1">\1<\/h2>/
	s/# (.*)$/<h1 id="\1">\1<\/h1>/

	s/!\[([A-Za-z0-9 ]+)\]\(([A-Za-z\/.:]+)\)/<img src="\2" alt="\1" \/>/
	s/\[([A-Za-z.0-9 ]+)\]\(([A-Za-z\/.:]+)\)/<a href="\2">\1<\/a>/
}
