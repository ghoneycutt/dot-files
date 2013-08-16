# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#-----------------------------------------------------------------------------
# Environment Variables
#-----------------------------------------------------------------------------

# User specific aliases and functions
export SVN_EDITOR='vim'
export EDITOR='vim'
export VISUAL='vim'

export CVSROOT=:ext:ghoneycutt@cvs.speakeasy.net:/usr/local/cvs/master
export CVS_RSH=/usr/bin/ssh
export LOCAL_PUPPETREPO_PATH=/home/gh/puppet

# List of suffixes to ignore when performing filename completion
export FIGNORE=".svn:.o:~"

# Use less as our pager
export PAGER=/usr/bin/less
export LESS=-R

# Needed for our custom version of 'less'
export MYVIMDIR="$HOME/.vim/"

# Do not create ._ metadata files on Mac OSX
export COPYFILE_DISABLE=true

#-----------------------------------------------------------------------------
# Aliases
#-----------------------------------------------------------------------------

alias diff="colordiff -Naur"
alias less="less -R -i -E -M -X $@"
alias vi="vim"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls -G' # colorized output
alias top='top -o cpu' # OSX's crazy top
alias rspec='rspec -c' # colorized rspec output

#-----------------------------------------------------------------------------
# Global Settings
#-----------------------------------------------------------------------------

# Save all lines of a multiple-line command in the same history entry
shopt -s cmdhist

#-----------------------------------------------------------------------------
# Initialization
#-----------------------------------------------------------------------------

# Source some subversion specific functions
source $HOME/.svn_bash_completion

# Import our custom file/directory colors
eval `dircolors -b $HOME/.dir_colors`

#-----------------------------------------------------------------------------
# Misc. Custom Functions
#-----------------------------------------------------------------------------

# display cert info
function certinfo () { openssl x509 -in $1 -noout -text; }

# display CSR info
function csrinfo () { openssl asn1parse -in $1; }

# colorized svn diffs
function svndiff () { svn diff $@ | colordiff; }

# colorized git diffs
function gitdiff () { git diff $@ | colordiff; }

# puppet template syntax checking
function pt()
{
    if [ -z $1 ]; then
        echo "usage: pt <puppet_template_file.erb>"
        return;
    fi
    /usr/bin/erb -P -x -T '-' $1 | /usr/bin/ruby -c
}

# puppet manifest syntax checking
function pc()
{
    if [ -z $1 ]; then
        puppet --ignoreimport --parseonly init.pp
    else
        puppet --ignoreimport --parseonly $1
    fi
}

# Custom less function, uses vim so we get syntax highlighting
function cless()
{
  if [ $# -eq 0 ]; then
    vim -c 'so $MYVIMDIR/tools/less.vim' -
  else
    vim -c 'so $MYVIMDIR/tools/less.vim' "$@"
  fi
}

# Show processes with a particular string in them
function pugrep()
{
  if [ -z $1 ]; then
    echo "usage: pugrep process"
    return;
  fi
  ps aux |\
  grep -i $1 |\
  awk '{printf("%8s%8d    %s %s %s %s\n", $1, $2, $11, $12, $13, $14)}'
}

# set the title of an xterm window
function xtitle ()
{
    case $TERM in
        * )
            echo -n -e "\033]0;$*\007" ;;
    esac
}

# Nice ls output
function ll(){ ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| egrep -v "^d|total "; }

# repeat $1 times $command, e.g. repeat 5 ls
function repeat()
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done

}

# Simple prompt for asking a question
function ask()
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

#-----------------------------------------------------------------------------
# File & String Related Functions
#-----------------------------------------------------------------------------

# Find a file with the string $1 in the name
function ff() { find . -name '*'$1'*' ; }

# Find a file with the string $1 in the name and exec $2 on it
function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }

# Find a file ending in $2 and search for string $1 in it
function fstr() # find a string in a set of files
{
    if [ $# -ne 2 ]; then
        echo "Usage: fstr \"pattern\" [files] "
        return;
    fi
    SMSO=$(tput smso)
    RMSO=$(tput rmso)
    find . -type f -name "*${2}" -print | xargs grep -sin "$1" | \
    sed "s/$1/$SMSO$1$RMSO/gI"
}

# Move filenames to lowercase
function lowercase()
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

# Swap file $1 with $2
function swap()
{
    local TMPFILE=tmp.$$
    mv $1 $TMPFILE
    mv $2 $1
    mv $TMPFILE $2

}

#-----------------------------------------------------------------------------
# Process/System related functions
#-----------------------------------------------------------------------------


# Helper function for pp
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

# Show all processes owned by me
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

