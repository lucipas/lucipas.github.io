#!/bin/sed -E
# tags that expand to other tags will go here

/^\s*\[\/\]/!{
	/<code>/,/<\/code>/!{
	/\?feet/r./src/components/footer.plate
	/\?feet/d
}}
