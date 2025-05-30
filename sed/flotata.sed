#!/bin/sed -E

# TODO do the css for these
# If this confuses you just imagine that the octothorpe is the whitespace
/\s*\[\]/!{
	s/#img (.+)/<img class="fr" src="\1" \/>/
	s/#img# (.+)/<img class="cent" src="\1" \/>/
	s/img# (.+)/<div class="fl" src="\1" \/>/
	# use .ed to close this out & put these on a ne
	s/#div/<div class="fr">/
	s/#div#/<div class="cent">/
	s/div#/<div class="fl">/




}
