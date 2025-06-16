#!/bin/sed


# slurp
:a
$!N
$!ba


:b
# the first tick tick tick should be the opening tag
s/```/<code><pre>/
# the second tick tick tick should be the closing tag
s/```/<\/pre><\/code>/
# if there is still tick tick ticks loop again
/```/bb

