# MacPorts Installer addition on 2009-10-05_at_11:45:06: adding an appropriate PATH variable for use with MacPorts.
#export PATH=$HOME/android-sdk-mac_x86/platform-tools:$HOME/android-sdk-mac_x86/tools:$HOME/bin:/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$HOME/android-sdk-mac_x86/platform-tools:$HOME/android-sdk-mac_x86/tools:$HOME/bin:/usr/texbin:/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2009-10-05_at_11:45:06: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.


export RUBYOPT=rubygems
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
export PYTHONPATH=$HOME/lib/python2.6/site-packages:/usr/local/lib/python2.7/site-packages
export DYLD_LIBRARY_PATH=/usr/local/opt/cairo/lib
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig
