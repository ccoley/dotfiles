# .bash_aliases contains aliases for Bash

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Easier navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias -- --='cd -' # Back to last working directory

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Get week number
alias week='date +%V'

# Date/Time aliases
alias now='date +%T'
alias nowtime=now
alias nowdate='date +%m-%d-%Y'

# IP address
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Confirm before overwrite
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

