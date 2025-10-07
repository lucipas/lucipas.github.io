#!/bin/sed -E

/---/,/---/!{
    /```/,/```/!{
        s/:::(.+)/<span class="censored">\1<\/span>/
    }
}