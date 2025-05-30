#!/bin/sed -E
# stuff that mayhaps contain a .something that maybe transformed into html tags that should not goes here

/^\s*\[\]/!{
	/\s+\*ssp/r./src/components/ssp.fnt.txt
	/\s+\*ssp/d
	/\s+\*jaq/r./src/components/jaq.fnt.txt
	/\s+\*jaq/d
	/\s+\*jq/r./src/components/jq.js.txt
	/\s+\*jq/d
	/\s+\*gtm/r./src/components/gtm.txt
	/\s+\*gtm/d
	s/\s+\*gsap/<script src=\"https:\/\/cdn\.jsdelivr\.net\/npm\/gsap@3\.13\.0\/dist\/gsap\.min\.js\"><\/script>/
}

# should go here b/c last of the processors
# keep tabing correct
s/(\s+)\[\]/\1/
