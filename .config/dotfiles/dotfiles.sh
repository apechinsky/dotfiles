# Dotfiles management script

# Dotfiles management is based on the following
# https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b

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

#
# Function output modified dotfiles and allows user to select changed ones
#
dotfiles-add() {
    dotfiles status -s | \
        sed -e "s|^.\{3\}|$PWD/|" | \
        fzf --multi --preview "bat {} --color=always" | \
        xargs git --git-dir="$dotfilesGitDir" --work-tree="$HOME" add
}
