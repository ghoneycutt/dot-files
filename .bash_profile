#export PATH=/opt/local/bin:/opt/local/sbin:$PATH:~/bin:~/.gem/ruby/1.8/bin/

export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH=$PATH:/Developer/usr/bin:~/bin

export SPEC_OPTS="--format documentation"
export PUPPET_GEM_VERSION="~> 7"

. ~/.bashrc

source ~/.profile
#source ~/.sensuctl_bash_completion
#source ~/.kubectl_bash_completion

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export GPG_TTY=$(tty)

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/gh/google-cloud-sdk/path.bash.inc' ]; then . '/Users/gh/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/Users/gh/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/gh/google-cloud-sdk/completion.bash.inc'; fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# puppet litmus fails without bumping the ulimit up
ulimit -n 4096
