# /etc/profile.d/*
fpath=(/home/zhuyiqing01/local/share/zsh/4.3.10/functions ${fpath})
setopt nonomatch
if [ -d /etc/profile.d ]; then
    for profile in /etc/profile.d/*.sh; do
        noglob source $profile
    done
fi
unsetopt nonomatch
unset profile

# Functions.
if [ -d ~/.zsh/functions ]; then
    for funct in ~/.zsh/functions/*; do
        source $funct
    done
fi
unset funct

# Dir colours.
eval $(dircolors $HOME/.dir_colors)

# Aliases.
alias ls='ls -FA --color=auto'
if [ -n "$STY" ]; then
    alias screen='screen -m -e"^Ss"'
fi
alias grep='grep --colour=auto'
alias ll='ls -lA --color=auto'
alias uptime='clear; logout' # XXX Training wheels.
alias ifconfig='clear; logout' # XXX Training wheels.

# Proxies.
#export ftp_proxy="http://cache.telkomsa.net:3128"

# Editor.
export EDITOR="vim"

# Man pager.
export MANPAGER="vimmanpager"

# Emacs ZLE.
bindkey -e

# Word chars
export WORDCHARS='*?_[]~=&;!#$%^(){}'

# Default dictionary
export DICTIONARY="en_GB"

# No external messages to my terminal.
mesg n

# History.
HISTSIZE=500000
HISTFILE=~/.zsh_history
SAVEHIST=500000
setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt shwordsplit

# Options
setopt complete_in_word
setopt auto_cd
setopt no_beep
setopt auto_pushd

# Compinit.
autoload -U compinit
compinit
zstyle ':completion::complete:*' use-cache 1

# zsh completions
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(< ~/.ssh/known_hosts)"}%%[# ]*}//,/ })'

# process completion
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# zstyle
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{yellow}%d%f%u'

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# Edit the command line with $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Prompt.
setopt prompt_subst
function _git_check_branch {
    local ref
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return 1
    echo -e "($fg_no_bold[white]"${ref#refs/heads/}"$fg_no_bold[cyan])-"
}

function _git_check_rebase {
    local git_dir
    git_dir=$(git rev-parse --git-dir 2>/dev/null) || return 1
    if [ -d "$git_dir/rebase-merge" -o -d "$git_dir/rebase-apply" ]; then
        echo -e "($fg_bold[cyan]rebasing$fg_no_bold[cyan])-"
    else
        return 1
    fi
}

function _git_check_stash {
    local ref
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return 1
    if git stash list | \
    awk 'BEGIN { _exit=1 }; $4 == "'${ref#refs/heads/}':" { _exit=0 } END { exit(_exit); } '; then
        echo -e "($fg_no_bold[cyan]stash$fg_no_bold[cyan])-"
    else
        return 1
    fi
}

function _show_logons {
    local logons
    return 0
}

function _newline_prompt_functions() {
    local prompt_function
    local output
    for prompt_function in ${_newline_prompt_functions[@]}; do
        data=$($prompt_function)
        if [ $? -eq 0 ]; then
            output="$data\n%{$reset_color%}"
        fi
    done
    if [[ -n ${output} ]]; then
        echo -e '%{$fg_no_bold[black]%}>%{$fg_no_bold[cyan]%}>>'${output}
    fi
}

autoload -U colors && colors

PS1=$'%{$reset_color%}\n\$(_newline_prompt_functions)%{$fg_no_bold[black]%}>%{$fg_no_bold[red]%}>%{$fg_no_bold[red]%}(%{$fg_no_bold[white]%}%n%{$fg_no_bold[cyan]%}@%{$fg_no_bold[yellow]%}%m%{$fg_no_bold[red]%})-\$(_git_check_branch)\$(_git_check_rebase)$(_git_check_stash)%(1j.(%{$fg_no_bold[red]%}%j%{$fg_no_bold[red]%}%)-.)\$(_show_logons)(%{$fg_no_bold[yellow]%}%D{%a %b %d} %*%{$fg_no_bold[red]%})-(%{$fg_no_bold[green]%}%!%{$fg_no_bold[red]%}/%{$fg_no_bold[white]%}%i%{$fg_no_bold[red]%})%(?..-(%{$fg_bold[cyan]%}%?%{$fg_no_bold[red]%}%))->%{$reset_color%}\n%{$fg_no_bold[black]%}>%{$fg_no_bold[red]%}(%{$fg_no_bold[yellow]%}%~%{$fg_no_bold[red]%}) %%> %{$reset_color%}'

# Path.
PATH="$HOME/sbin:$HOME/bin:$PATH"

# Umask.
umask 022

# ssh-agent.
if ! ssh-add -l > /dev/null 2>&1; then
    if [ -f ~/.ssh-agent ]; then
        if ! pgrep -U $USER -x ssh-agent > /dev/null; then
            ssh-agent | grep -v ^echo > ~/.ssh-agent
            . ~/.ssh-agent
            ssh-add
        else
            . ~/.ssh-agent
            if ! ssh-add -l > /dev/null 2>&1; then
                ssh-add
            fi
        fi
    fi
fi

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
            hosta=("${(@s/./)*}")
            tmux rename-window $hosta[1]
            command ssh "$@"
            tmux set-window-option automatic-rename "on" >/dev/null
    else
            command ssh "$@"
    fi

}

# gpg-agent. disabled
#if which gpg-agent &> /dev/null; then
#    if ! pgrep -U $USER -x gpg-agent > /dev/null; then
#        eval $(gpg-agent --daemon --quiet --write-env-file)
#    elif [ -f ~/.gpg-agent-info ]; then
#        . ~/.gpg-agent-info
#        export GPG_AGENT_INFO
#    fi
#fi

# Set the title (in tmux).
function _set_tmux_title()
{
    print -nRP $'\033k'
    print -rn -- "$1"
    print -nRP $'\033'\\
}

# X11 Terminals.
_tmux_title=""
_tmux_title_automatic=1
case $TERM in
    xterm*|rxvt|(K|a)term)
        precmd () {
            print -Pn "\033]0;%n@%m%  %~\a"
        }
        preexec () {
            local -h line="${(V)1}"
            print -Pn "\033]0;%n@%m%  <"
            print -rn -- "$line>"
            print -n "\a"
        }
        ;;
    screen*)
        precmd () {
            if [[ ${_tmux_title_automatic} -eq 1 ]]; then
                if [[ -n ${_tmux_title} ]]; then
                    print -nRP $'\033k'
                    print -rn -- "$_tmux_title"
                    print -nRP $'\033'\\
                    return
                fi
                print -nRP $'\033k'%c$'\033'\\
            fi
        }
        preexec () {
            if [[ ${_tmux_title_automatic} -eq 1 ]]; then
                local -h line="${(V)1}"
                set -- ${line}
                if [[ -n ${_tmux_title} ]]; then
                    print -nRP $'\033k'
                    print -rn -- "$_tmux_title"
                    print -nRP $'\033'\\
                    return
                fi
                case "$1" in
                    ssh)
                        print -nRP $'\033k'
                        print -rn -- "$1 $2"
                        print -nRP $'\033'\\
                    ;;
                    *)
                        print -nRP $'\033k'
                        print -rn -- "$1"
                        print -nRP $'\033'\\
                    ;;
                esac
            fi
        }
esac

# Zle.
function backward-kill-to-slash() {
    local WORDCHARS="${WORDCHARS:s,/,} \\\'"

    [[ $BUFFER != */* ]] && return
    [[ $LBUFFER == [^/]##/ ]] && return

    zle backward-kill-word
}

zle -N backward-kill-to-slash

function backward-word-to-slash () {
    local WORDCHARS="${WORDCHARS:s,/,} \\\'"

    [[ $BUFFER != */* ]] && return
    [[ $LBUFFER == [^/]##/ ]] && return

    zle backward-word
}

zle -N backward-word-to-slash

bindkey '^[^?' backward-kill-to-slash

