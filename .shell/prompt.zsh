# ~/.shell/prompt.zsh

# solarized colors {{{
# http://ethanschoonover.com/solarized

autoload -U colors && colors

typeset -lA solarized
solarized[BASE03]=$'\e[38;5;234m'
solarized[BASE02]=$'\e[38;5;235m'
solarized[BASE01]=$'\e[38;5;240m'
solarized[BASE00]=$'\e[38;5;241m'
solarized[BASE0]=$'\e[38;5;244m'
solarized[BASE1]=$'\e[38;5;245m'
solarized[BASE2]=$'\e[38;5;254m'
solarized[BASE3]=$'\e[38;5;230m'
solarized[YELLOW]=$'\e[38;5;136m'
solarized[ORANGE]=$'\e[38;5;166m'
solarized[RED]=$'\e[38;5;160m'
solarized[MAGENTA]=$'\e[38;5;125m'
solarized[VIOLET]=$'\e[38;5;61m'
solarized[BLUE]=$'\e[38;5;33m'
solarized[CYAN]=$'\e[38;5;37m'
solarized[GREEN]=$'\e[38;5;64m'
RESET_COLOR="%{$terminfo[sgr0]%}"

# }}}

setopt prompt_subst

function git_prompt {
    local GIT_SYMBOL="%%{$solarized[GREEN]%%}± "
    local DIRTY_COLOR="%%{$solarized[YELLOW]%%}"
    local CLEAN_COLOR="%%{$solarized[GREEN]%%}"
    local UNMERGED_COLOR="%%{$solarized[RED]%%}"

    case "$PWD" in
        /mnt/*|/Volumes/*) return ;;
    esac

    git rev-parse --git-dir > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        return
    fi

    local ref
    ref=${$(command git symbolic-ref HEAD 2> /dev/null)#refs/heads/} || \
        ref=${$(command git rev-parse HEAD 2>/dev/null)[1][1,7]} || \
        return

    local branchcolor
    if [[ `git ls-files -u >& /dev/null` == '' ]]; then  # in a merge?
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]; then
        branchcolor=$DIRTY_COLOR
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]; then
          branchcolor=$DIRTY_COLOR
        else
          branchcolor=$CLEAN
        fi
      fi
    else
      branchcolor=$UNMERGED_COLOR
    fi
    print -Pn '%%{${solarized[BASE0]}%%}('
    print -Pn '${GIT_SYMBOL}%%{$branchcolor%%}%50>..>${ref}%<<'
    print -Pn '%%{${solarized[BASE0]}%%}) '
}

setprompt () {
    local MAX_DIR_LEN=45
    PROMPT='$(git_prompt)'"%{${solarized[BASE0]}%}%(!.#.>)${RESET_COLOR} "
    RPROMPT='%{${solarized[YELLOW]}%}%n@%m:%45<...<%~%<<${RESET_COLOR}'
    PS2='(%_)${RESET_COLOR} '
}

setprompt

unset git_prompt setprompt
