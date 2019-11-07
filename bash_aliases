#################
#    Aliases    #
#################

# some ls aliases
alias l='ls -CF'
alias ll='ls -alF'
alias la='ls -A'
alias lh='ls -alFh'

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
alias nowtime='now'
alias nowdate='date +%m-%d-%Y'
alias timezone='date +"%Z (GMT %:z)"'

# Get week number
alias week='date +%V'

# IP address
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Confirm before overwrite
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Make mkdir verbose
alias mkdir='mkdir -v'

# Continue downloads in case of problems
alias wget='wget -c'

# Get the size of the current directory, exluding any .git sub-directories
alias dume='du -h --exclude="*.git*" | sort -h'

# Make free output more human friendly
alias free='free -ht'

# Find VIM swap files. Pass the -delete flag to delete them
alias swp='find . -type f -name ".*.sw?"'

###################
#    Functions    #
###################

# Basic benchmark with cURL
alias _curl_time='echo "curl_time(): Show timing info for a cURL request"'
function curl_time {
    curl -s -o /dev/null -w "\
   namelookup:  %{time_namelookup}s\n\
      connect:  %{time_connect}s\n\
   appconnect:  %{time_appconnect}s\n\
  pretransfer:  %{time_pretransfer}s\n\
     redirect:  %{time_redirect}s\n\
starttransfer:  %{time_starttransfer}s\n\
----------------------\n\
        total:  %{time_total}s\n" "$@"
}

# Count the number of files in a directory and its sub-directories
alias _count='echo "count(): Count the number of files in a directory and its sub-directories"'
function count {
    find $1 -type f | wc -l
}

# Show a histogram output of commands in history
alias _hist='echo "hist(): Show a histogram output of commands in history"'
function hist {
    history | awk '{if ($2 == "sudo") {print $2,$3} else {print $2}}' | sort -n | uniq -c | sort -nr | head -n20
}

# Make a directory, then cd into it
alias _mcd='echo "mcd(): Make a directory, then cd into it"'
function mcd {
    mkdir -pv $1
    cd $1
    pwd
}

# Print a color chart
alias _color='echo "color(): Print a color chart"'
function color {
    # Background Color
    for clbg in {40..47} {100..107} ; do
        # Foreground Color
        for clfg in {30..37} {90..97} ; do
            # Formatting
            for frmt in 0 1 2 4 5 7 8 ; do
                # Print the combination. Order doesn't matter, except in one
                # specific case. If frmt is 0, then it has to be first because
                # it is techinally a reset code and it will reset anything
                # before it in the combination. Because of that edge case, it's
                # probably best to always put frmt first in the combination.
                echo -en " \e[${frmt};${clfg};${clbg}m\\\e[${frmt};${clfg};${clbg}m\e[0m "
            done
            echo
        done
        echo
    done
    echo -e "\e[0m";
}

# Prints the Title and Uploaded Art Path for any media item that match the
# query parameter.
#
# Accepts a title's "Rating Key" also know as "Metadata Key", or a string to
# match against the title. The string must be quoted if it's multiple words.
alias _plex-search='Search for Plex media by ID or title. Requires SUDO'
function plex-search {
    dbString='file:///var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db?mode=ro'
    if [[ $1 =~ ^[0-9]+$ ]]; then
        # Return an exact match by metadata_items.id
        sudo sqlite3 "$dbString" "SELECT quote(title), quote('Metadata/' || CASE section_type WHEN 1 THEN 'Movies' WHEN 2 THEN 'TV Shows' ELSE 'Unknown' END || '/' || substr(hash,1,1) || '/' || substr(hash,2) || '.bundle/Uploads') FROM metadata_items JOIN library_sections ON library_sections.id = metadata_items.library_section_id WHERE metadata_items.id='$1' ORDER BY section_type ASC"
    else
        # Return a LIKE match against metadata_items.title, but only for Movies and TV Episodes.
        #
        # Here are the known metadata_types:
        # 1: Movie
        # 2: TV Show
        # 3: TV Season
        # 4: TV Episode
        # 8: Music Artist
        # 9: Music Album
        # 10: Music Track
        # 12: Movie Extra
        # 15: Playlist
        # 18: Collection
        # 42: Plex Internal Stuff
        sudo sqlite3 "$dbString" "SELECT quote(title), quote('Metadata/' || CASE section_type WHEN 1 THEN 'Movies' WHEN 2 THEN 'TV Shows' ELSE 'Unknown' END || '/' || substr(hash,1,1) || '/' || substr(hash,2) || '.bundle/Uploads') FROM metadata_items JOIN library_sections ON library_sections.id = metadata_items.library_section_id WHERE metadata_items.title LIKE '%$1%' AND metadata_type IN (1,4) ORDER BY section_type ASC"
    fi
}
