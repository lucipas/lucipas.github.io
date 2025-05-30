[[ "$-" != *i* ]] && return
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
  alias vsc='code ./ > /dev/null &'
  alias cls='clear'
  alias xarg='xargs'
  alias so='source'
  alias 5mt='sleep 5m && echo 00000111 | basenc --base2msbf --decode &'

alias df='df -h'
alias du='du -h'
 alias less='less -r'                          # raw control characters
 alias whence='type -a'                        # where, of a sort
 alias grep='grep --color'                     # show differences in colour
 alias egrep='egrep --color=auto'              # show differences in colour
 alias fgrep='fgrep --color=auto'              # show differences in colour
 alias l='ls -hFA --color=tty'                 # classify files in colour
 alias ls="ls -hFA --color=tty"
 alias dir='ls --color=auto --format=vertical'
 alias vdir='ls --color=auto --format=long'
 alias bell='echo 00000111 | basenc --base2msbf --decode'
 settitle () 
 { 
   echo -ne "\e]2;$@\a\e]1;$@\a"; 
 }
cd_func ()
 {
   local x2 the_new_dir adir index
   local -i cnt
 
   if [[ $1 ==  "--" ]]; then
     dirs -v
     return 0
   fi
 
   the_new_dir=$1
   [[ -z $1 ]] && the_new_dir=$HOME
 
   if [[ ${the_new_dir:0:1} == '-' ]]; then
     #
     # Extract dir N from dirs
     index=${the_new_dir:1}
     [[ -z $index ]] && index=1
     adir=$(dirs +$index)
     [[ -z $adir ]] && return 1
     the_new_dir=$adir
   fi
 
   #
   # '~' has to be substituted by ${HOME}
   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
 
   #
   # Now change to the new dir and add to the top of the stack
   pushd "${the_new_dir}" > /dev/null
   [[ $? -ne 0 ]] && return 1
   the_new_dir=$(pwd)
 
   #
   # Trim down everything beyond 11th entry
   popd -n +11 2>/dev/null 1>/dev/null
 
   #
   # Remove any other occurence of this dir, skipping the top of the stack
   for ((cnt=1; cnt <= 10; cnt++)); do
     x2=$(dirs +${cnt} 2>/dev/null)
     [[ $? -ne 0 ]] && return 0
     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
     if [[ "${x2}" == "${the_new_dir}" ]]; then
       popd -n +$cnt 2>/dev/null 1>/dev/null
       cnt=cnt-1
     fi
   done
 
   return 0
 }
# 
 alias cd=cd_func
