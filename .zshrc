# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH=/home/apechinsky/.oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="gallois-my"
ZSH_THEME="eastwood-my"
# ZSH_THEME="simple"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

JIRA_URL=https://jira.qulix.com

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# git-prompt
# git
plugins=(
    git
    git-prompt
    adb
    docker
    history-substring-search
    spring
    jira
    themes
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

alias -s pdf="evince"

# bindkey -v

# source my environment
source $HOME/_environment/env.sh

#
# Directory bookmarks (shortcuts) support function 'cdg' (cd global)
#
# Usage:
#   $ cdg
#
# Function activates dir selection using Fuzzy finder.
# After selection jumps to selected dir.
#
# Bookmark dirs are defined in '~/.bookmarks' file.
#
unalias cdg 2> /dev/null
cdg() {
    local bookmarks_file=~/.bookmarks

    if [[ -r $bookmarks_file ]]; then

        local dirs=$(cat "$bookmarks_file" | sed '/^\s*$/d' | sed '/^#.*/d')
        local dest_dir=$(echo -e "$dirs" | fzf --height=40%)

        if [[ "${dest_dir:0:4}" == 'EDIT' ]]; then
            $(eval echo "$EDITOR ${dest_dir:5}")
        elif [[ $dest_dir != '' ]]; then
            cd $(eval echo "${dest_dir}")
        fi
    fi
}

bindkey -s '^B' 'cdg\n'
bindkey -s '^G^B' 'git-checkout-branch\n'
bindkey -s '^G^S' 'git status\n'
bindkey -s '^G^K' 'git checkout '

bindkey -s '^V' 'feh --keep-zoom-vp --quiet \n'

source $HOME/bin/tagged-commands.sh
source $HOME/work/qulix/alfabank/alfabank.sh
source $HOME/work/qulix/alfabank/acquiring/acquiring.sh
source $HOME/work/qulix/alfabank/deposits/deposits.sh
source $HOME/work/qulix/alfabank/products/products.sh
source $HOME/work/qulix/alfabank/getcard/getcard.sh
source $HOME/work/qulix/alfabank/cards/cards.sh

#
# Git-Checkout-Branch
# Choose and checkout remote/local git branch.
#
git-checkout-branch() {
    local selectedBranch=$(git branch -a | sed -n 's/remotes\/origin\///p' | sort -u | fzf | xargs)
    echo "branch: '$selectedBranch'"
    test -n "$selectedBranch" && git checkout $selectedBranch
}

set +o noclobber

# prevent shell from being closed with ctrl-d
set -o ignoreeof

source /opt/asdf-vm/asdf.sh

[[ -f ~/.fzf.zsh ]] && source $HOME/.fzf.zsh


source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# CSREPO tool initialization
export CSREPO_HOME="/home/apechinsky/.csrepo"
export CSREPO_JAVA_HOME="$CSREPO_HOME/repository/net.adoptopenjdk/jre-1.8.0_252-linux64"
[[ -d "${CSREPO_HOME}/bin" ]] && export PATH="$PATH:$CSREPO_HOME/bin"



# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"
