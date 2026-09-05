# Dotfiles management script

# Dotfiles management is based on the following
# * https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b
# * https://www.atlassian.com/git/tutorials/dotfiles

dotfilesHome=$(cd $(dirname $0); pwd)
dotfilesGitDir="$dotfilesHome/git/"

# dotfiles config --local status.showUntrackedFiles no
# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

#
# Calls git with predefined git dir and workspace dir.
# Git dir points to .git directory
# workspace dir is home dir
#
dotfiles() {
    git --git-dir=$dotfilesHome/git --work-tree=$HOME "$@"
}

alias config='dotfiles'

#
# Function output modified dotfiles and allows user to select changed ones
#
dotfiles-add() {
    dotfiles status -s -uall . | \
        sed -e "s|^.\{3\}|$PWD/|" | \
        fzf --multi --preview "bat {} --color=always" | \
        xargs git --git-dir="$dotfilesGitDir" --work-tree="$HOME" add
}

#
# Interactive dotfiles manager.
#
# Key bindings:
#   enter   stage selection and exit
#   ctrl-a  stage selection, stay in fzf
#   ctrl-d  discard changes in selection, stay in fzf
#
dotfiles-manage() {
    local git="git --git-dir=$dotfilesGitDir --work-tree=$HOME"
    local list="$git status -s -uall . | sed -e 's|^.\{3\}|$PWD/|'"

    eval "$list" | \
        fzf --multi \
            --preview "bat {} --color=always" \
            --header 'enter: add | ctrl-a: add | ctrl-d: discard changes' \
            --bind "ctrl-a:execute-silent($git add {+})+reload($list)" \
            --bind "ctrl-d:execute-silent($git checkout HEAD -- {+} 2>/dev/null)+reload($list)" | \
        xargs -r $git add
}
