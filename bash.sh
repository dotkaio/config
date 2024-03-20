#!/bin/zsh
#umask 077

function get_git_branch {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return
    echo ${ref#refs/heads/}
}
