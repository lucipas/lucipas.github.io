#!/bin/sed -E

/---/,/---/!{ # not in the yaml
    /```/,/```/!{ # not in the code blocks

        /::menu::/,/\n?^$/{ # from menu to next empty newline (non-greedy)
            s/^:item: (.+?), (.+?), (.+?)$/<div class="takeout-box"><p class="item-name">\1<\/p><p class="item-price">\3<\/p><p class="menu-description">\2<\/p><\/div>/

            
    
    
    
    
    
    
    
    
        }
    }
}

