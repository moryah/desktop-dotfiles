# /etc/zsh/zshrc: system-wide .zshrc file for zsh(1).
#
# This file is sourced only for interactive shells. It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

READNULLCMD=${PAGER:-/usr/bin/pager}

# An array to note missing features to ease diagnosis in case of problems.
typeset -ga debian_missing_features

if [[ -z "${DEBIAN_PREVENT_KEYBOARD_CHANGES-}" ]] &&
   [[ "$TERM" != 'emacs' ]]
then

    typeset -A key
    key=(
        BackSpace  "${terminfo[kbs]}"
        Home       "${terminfo[khome]}"
        End        "${terminfo[kend]}"
        Insert     "${terminfo[kich1]}"
        Delete     "${terminfo[kdch1]}"
        Up         "${terminfo[kcuu1]}"
        Down       "${terminfo[kcud1]}"
        Left       "${terminfo[kcub1]}"
        Right      "${terminfo[kcuf1]}"
        PageUp     "${terminfo[kpp]}"
        PageDown   "${terminfo[knp]}"
    )

    function bind2maps () {
        local i sequence widget
        local -a maps

        while [[ "$1" != "--" ]]; do
            maps+=( "$1" )
            shift
        done
        shift

        sequence="${key[$1]}"
        widget="$2"

        [[ -z "$sequence" ]] && return 1

        for i in "${maps[@]}"; do
            bindkey -M "$i" "$sequence" "$widget"
        done
    }

    bind2maps emacs             -- BackSpace   backward-delete-char
    bind2maps       viins       -- BackSpace   vi-backward-delete-char
    bind2maps             vicmd -- BackSpace   vi-backward-char
    bind2maps emacs             -- Home        beginning-of-line
    bind2maps       viins vicmd -- Home        vi-beginning-of-line
    bind2maps emacs             -- End         end-of-line
    bind2maps       viins vicmd -- End         vi-end-of-line
    bind2maps emacs viins       -- Insert      overwrite-mode
    bind2maps             vicmd -- Insert      vi-insert
    bind2maps emacs             -- Delete      delete-char
    bind2maps       viins vicmd -- Delete      vi-delete-char
    bind2maps emacs viins vicmd -- Up          up-line-or-history
    bind2maps emacs viins vicmd -- Down        down-line-or-history
    bind2maps emacs             -- Left        backward-char
    bind2maps       viins vicmd -- Left        vi-backward-char
    bind2maps emacs             -- Right       forward-char
    bind2maps       viins vicmd -- Right       vi-forward-char

    # Make sure the terminal is in application mode, when zle is
    # active. Only then are the values from $terminfo valid.
    if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
        function zle-line-init () {
            emulate -L zsh
            printf '%s' ${terminfo[smkx]}
        }
        function zle-line-finish () {
            emulate -L zsh
            printf '%s' ${terminfo[rmkx]}
        }
        zle -N zle-line-init
        zle -N zle-line-finish
    else
        for i in {s,r}mkx; do
            (( ${+terminfo[$i]} )) || debian_missing_features+=($i)
        done
        unset i
    fi

    unfunction bind2maps

fi # [[ -z "$DEBIAN_PREVENT_KEYBOARD_CHANGES" ]] && [[ "$TERM" != 'emacs' ]]

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                           /usr/local/bin  \
                                           /usr/sbin       \
                                           /usr/bin        \
                                           /sbin           \
                                           /bin            \
                                           /usr/X11R6/bin

(( ${+aliases[run-help]} )) && unalias run-help
autoload -Uz run-help



##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=50000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed



##############################################################################
# Alias Configuration
##############################################################################

alias ll='ls -lah'
alias v='vim'
alias s='sudo'
alias i='gpicview'
alias p='mplayer'
alias wf='~/.wifi.sh'
alias dh='df -h'
alias bye='s shutdown -h now'
alias c-='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'



##############################################################################
# Autocompletation Configuration
##############################################################################

zstyle ':completion:*:cd:*' ignored-patterns '(*/)#.mc' '(*/)#.gem'
zstyle ':completion:*:sudo:*' ignored-patterns '(*/)#.mc' '(*/)#.gem'



##############################################################################
# tmux loading
##############################################################################

if command -v tmux>/dev/null; then
[[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi


##############################################################################
# Prompt Configuration
##############################################################################


autoload -U colors && colors
PS1="
%{$fg[blue]%}%1~ %{$fg[red]%}%\> %{$reset_color%}%"

export NVM_DIR="/home/rafael/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

setopt completealiases

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

chpwd() { ll }

autoload -Uz colors
colors

# setting for dividing word
autoload -Uz select-word-style
select-word-style default
# # these letters are treated as dividing letters
zstyle ':zle:*' word-chars " /=;@:{}, |"
zstyle ':zle:*' word-style unspecified

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'


source /usr/share/zsh-antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-completions

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply
