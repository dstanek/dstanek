# ~/.zshrc

# completion {{{
autoload -U compinit && compinit
# }}}

# prompt {{{
autoload -U colors && colors
source ~/.shell/prompt.zsh
# }}}

# $PATH {{{
typeset -U path
path=($HOME/bin /usr/local/bin /usr/local/sbin $path[@])
# }}}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

#plugins=(brew django git knife osx pip pythonbrew rvm vagrant vi-mode history)
#plugins=(brew django git osx pip vagrant vi-mode history)


# oh-my-zsh sets correct_all and it drives me crazy
unsetopt correct_all

bindkey -M viins ‘jj’ vi-cmd-mode

source ~/.shell/functions
source ~/.shell/aliases
#source ~/.shell/variables
for F in ~/.shell/lib/*; do
    source $F
done

# vim:ft=zsh:fdm=marker
