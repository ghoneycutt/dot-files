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

# EC2 tools
export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/
export EC2_HOME=/Users/gh/amazon/ec2-api-tools

# aws tab completion
#complete -C /opt/local/Library/Frameworks/Python.framework/Versions/3.4/bin/aws_completer aws

export CVS_RSH=/usr/bin/ssh

# List of suffixes to ignore when performing filename completion
export FIGNORE=".svn:.o:~"

# Use less as our pager
export PAGER=/usr/bin/less
export LESS=-R

# Needed for our custom version of 'less'
export MYVIMDIR="$HOME/.vim/"

# Do not create ._ metadata files on Mac OSX
export COPYFILE_DISABLE=true

# Go
export GOPATH=$HOME/go
export GOROOT=$HOME/goroot

# https://consoledonottrack.com/
export DO_NOT_TRACK=1

#-----------------------------------------------------------------------------
# Aliases
#-----------------------------------------------------------------------------

alias diff="colordiff -Naur"
alias less="less -R -i -E -M -X $@"
alias vi="/usr/local/bin/vim"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls -G' # colorized output
alias top='top -o cpu' # OSX's crazy top
alias rspec='rspec -c' # colorized rspec output
alias grep='grep --color=auto'
alias tree="tree -a -I .git $@"
alias bi='bundle install'
alias be="bundle exec $@"
alias berc='bundle exec rake spec_clean spec_prep'
alias berp='bundle exec rake validate lint spec_standalone'
alias gc="git cherry-pick $@"
#alias gpum='git checkout master && git pull upstream master'
alias g="gcloud $@"

#-----------------------------------------------------------------------------
# Global Settings
#-----------------------------------------------------------------------------

# Save all lines of a multiple-line command in the same history entry
shopt -s cmdhist

HISTFILESIZE=2500

#-----------------------------------------------------------------------------
# Initialization
#-----------------------------------------------------------------------------

# Source some subversion specific functions
source $HOME/.svn_bash_completion

#source git bash completion
source $HOME/.git_bash_completion

source $HOME/.iterm2_shell_integration.bash

# Import our custom file/directory colors
eval `/usr/local/bin/gdircolors -b $HOME/.dir_colors`

# Google gcloud
source $HOME/google-cloud-sdk/completion.bash.inc
source $HOME/google-cloud-sdk/path.bash.inc

#-----------------------------------------------------------------------------
# Misc. Custom Functions
#-----------------------------------------------------------------------------

source $HOME/bin/promptline.sh
## change prompt when using git
#function parse_git_branch {
#  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
#}
#if [ $EUID == '0' ]; then
#  PS1="\[\e[32m\]\$(parse_git_branch)\[\e[m\]\h:\W # "
#else
#  PS1="\[\e[32m\]\$(parse_git_branch)\[\e[m\]\h:\W\$ "
#fi
#export PS1

# sensu
function sensuclients {
  curl -s http://admin:secret@127.0.0.1:4567/clients | jq .[].name | awk -F \" '{print $2}' | awk -F \. '{print $1}' | sort
}
# sensu2
function sclients {
  sensuctl entity list --format json | jq .[].id | sort
}
# sensu2 - delete all clients
function dclients {
  for i in $(sclients |awk -F \" '{print $2}'); do sensuctl entity delete --skip-confirm $i 2>/dev/null; done
}

# display cert info
function certinfo () { openssl x509 -in $1 -noout -text; }

# display CSR info
function csrinfo () { openssl asn1parse -in $1; }

# show all certs for a target. Target is in the form hostname:port
function certdns ()
{
    local target=$1;
    openssl s_client -showcerts -connect ${target} < /dev/null 2>&1 | openssl x509 -noout -text | gsed -rn '/DNS/{s/[ \t]+//g;s/,/\n/g;s/:/ = /pg}' | sort -h
}

function vsh () { vagrant ssh; }

# colorized svn diffs
function svndiff () { svn diff $@ | colordiff; }

# colorized git diffs
function gitdiff () { git diff $@ | colordiff; }

# find modules in use
function fm()
{
  if [ -z $1 ]; then
    find . -type f -name Modulefile
  else
    find $1 -type f -name Modulefile
  fi
}

# find names of modules in use
function fmn()
{
  if [ -z $1 ]; then
    find . -type f -name Modulefile | xargs grep name |grep -v \# | awk '{print $2}' | awk -F \' '{print $2}'
  else
    find $1 -type f -name Modulefile | xargs grep name |grep -v \# | awk '{print $2}' | awk -F \' '{print $2}'
  fi
}

# puppet lint
function pl()
{
    if [ -z $1 ]; then
      puppet lint init.pp
    else
      puppet lint $1
    fi
}

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
        puppet parser validate init.pp
    else
        puppet parser validate $1
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



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# https://direnv.net/
eval "$(direnv hook bash)"

# added by travis gem
[ -f /Users/gh/.travis/travis.sh ] && source /Users/gh/.travis/travis.sh
