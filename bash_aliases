
#################
#    Aliases    #
#################

# some ls aliases
alias ll='ls -alGF'
alias la='ls -AG'
alias l='ls -CFG'

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

# Date/Time aliases
alias now='date +%T'
alias nowtime=now
alias nowdate='date +%m-%d-%Y'

# Get week number
alias week='date +%V'

# IP address
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Confirm before overwrite
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Make parent directories with mkdir
alias mkdir='mkdir -pv'

# Continue downloads in case of problems
alias wget='wget -c'

# Get the size of the current directory, exluding any .git sub-directories
alias dume='du -h --exclude="*.git*" | sort -h'

# Make free output more human friendly
alias free='free -mt'

# Print a color chart
alias color='
    for x in 0 1 4 5 7 8;
        do for i in `seq 30 37`;
            do for a in `seq 40 47`;
                do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m ";
                done;
            echo;
            done;
        done;
    echo "";'

###################
#    Functions    #
###################

# Count the number of files in a directory and its sub-directories
function count {
    find $1 -type f | wc -l
}

# Show a histogram output of commands in history
function hist {
    history | awk "{print $2}" | sort -n | uniq -c | sort -n | tail
}

# Make a directory, then cd into it
function mcd {
    mkdir -pv $1
    cd $1
    pwd
}