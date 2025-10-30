#!/bin/sed -E

/---/,/---/!{ # not in the yaml
    /```/,/```/!{ # not in the code blocks



    }
}

