Set-Alias python py
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias ed nvim
Set-Alias .. cd..
Set-Alias l ls
Set-Alias cl cls
Set-Alias touch New-Item
set-alias jj z
Invoke-Expression (& { (zoxide init powershell | Out-String)})

function Prompt(){
	return "$(Get-Date) // $(Get-Location) "
	}

function psh {
	powershell -NoLogo
    }

function ?g{
    param([string]$s)
    start "https://www.google.com/search?q=$s&udm=14"
}


function ?yt{
    param([string]$s)
    start "https://www.youtube.com/results?search_query=$s"
}


function ?fsc{
    param([string]$s)
    start "https://findsecuritycontacts.com/query/$s"
    }

function ?gh{
    param([string]$s)
    start "https://github.com/search?q=$s&type=repositories"
    }

function ?ghusers{
    param([string]$s)
    start "https://github.com/search?q=$s&type=users"
    }

function ?sof{
    param([string]$s)
    start "https://stackoverflow.com/search?q=$s"
    }

function ?ddg{
    param([string]$s)
    start "https://duckduckgo.com/?q=$s"
    }

function yt{
    start "https://www.youtube.com"
    }

function hn{
    start "https://news.ycombinator.com/"
    }


function ig{
    start "https://www.instagram.com/"
    }

function ?igusers{
    param([string]$s)
    start "https://www.instagram.com/$s"
    }

function bsky{
    start "https://bsky.app"
    }

function scafweb{
    mkdir css
    mkdir js
    mkdir assets
    touch index.html
    touch "./js/index.js"
    touch "./css/index.css"
    touch "README.md"
    }




