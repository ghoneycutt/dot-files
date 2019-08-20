#export PATH=/opt/local/bin:/opt/local/sbin:$PATH:~/bin:~/.gem/ruby/1.8/bin/

export PATH=/opt/local/bin:/opt/local/sbin:$PATH:/Developer/usr/bin:~/bin

export SPEC_OPTS="--format documentation"
#export PUPPET_GEM_VERSION=3.8.7
export PUPPET_GEM_VERSION=6.4.1

. ~/.bashrc

# MacPorts Installer addition on 2014-09-29_at_14:27:55: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/.profile
source <(sensuctl completion bash)

# MacPorts Installer addition on 2016-12-30_at_16:07:17: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export GPG_TTY=$(tty)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gh/google-cloud-sdk/path.bash.inc' ]; then . '/Users/gh/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gh/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/gh/google-cloud-sdk/completion.bash.inc'; fi
