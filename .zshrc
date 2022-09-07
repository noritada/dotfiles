export PATH=$HOME/.cargo/bin:$HOME/.nodebrew/current/bin:$HOME/android-sdk-mac_x86/platform-tools:$HOME/android-sdk-mac_x86/tools:$HOME/.local/bin:$HOME/bin:/usr/texbin:/usr/local/opt/gettext/bin:$PATH
source $HOME/.poetry/env
export MANPATH=$MANPATH

export RUBYOPT=rubygems

export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="/usr/local/opt/python@3.9/bin:$PATH"

export GOPATH="$HOME/go"
export PATH=$PATH:"$GOPATH/bin"

export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
bindkey -e
setopt extended_glob
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt inc_append_history
setopt prompt_subst
PROMPT='%B%n[%T]%#%b '
RPROMPT='%B%m:%~%b'
unsetopt BEEP
export PYTHONPATH=$HOME/lib/python2.6/site-packages:/usr/local/lib/python2.7/site-packages
export DYLD_LIBRARY_PATH=/usr/local/opt/cairo/lib

# Backward killing for paths/URLs.
tcsh-backward-delete-word () {
  local WORDCHARS="${WORDCHARS:s#/#}"
  zle backward-delete-word
}

zle -N tcsh-backward-delete-word
bindkey '^W' tcsh-backward-delete-word

fpath+=~/.zfunc
autoload -U compinit
compinit
