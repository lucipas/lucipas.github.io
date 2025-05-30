#!/bin/sed -E
# This script is used for elements that can change over time like
# components or copyrights
# will use a asterisk to denotate

# templates need to be before all of the other tags.
# use .ed to close out these tags.
s/\*crd/<div class="crd">/
s/\*warn/<div class="warn">/
s/\*err/<div class="err">/
s/\*log/<div class="log">/

# these need to be on their own line.
/\*cpr/r./src/components/cpright.txt
/\*cpr/d
/\*pub/r./src/components/lastpub.txt
/\*pub/d
/\*motd/r./src/components/motd.txt
/\*motd/d
