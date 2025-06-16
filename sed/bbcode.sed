#!/bin/sed -E

# inline tags


/^\s*\[\/\]/!{
	/<code>/,/<\/code>/!{
	s/\[err\]/<span class="err">/
	s/\[warn\]/<span class="warn">/
	s/\[ok\]/<span class="ok">/
	s/\[cls="(.+)"\]/<span class="\1">/
	s/\[\/\]/<\/span>/
}
}
