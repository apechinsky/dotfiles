# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="gallois-my"
ZSH_THEME="dstufft" # set by `omz`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    git-prompt
    docker
    history-substring-search
    spring
    jira
    themes
    zsh-syntax-highlighting
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
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

alias -s pdf="evince"

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
        elif [[ "${dest_dir:0:4}" == 'OPEN' ]]; then
            $(eval echo "xdg-open ${dest_dir:5}")
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

if [[ -f $HOME/projects.sh ]]; then
    source $HOME/projects.sh
fi

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

source <(fzf --zsh)

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# CSREPO tool initialization
[[ -d "/home/apechinsky/.csrepo/bin" ]] && export PATH="$PATH:/home/apechinsky/.csrepo/bin"

eval "$(zoxide init --cmd cd zsh)"

export VAGRANT_HOME="/home/apechinsky/vm/vagrant"

# opencode
export PATH=/home/apechinsky/.opencode/bin:$PATH



# bun completions
[ -s "/home/apechinsky/.bun/_bun" ] && source "/home/apechinsky/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Dev containers CLI
export PATH="$HOME/.devcontainers/bin:$PATH"
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/apechinsky/.opam/opam-init/init.zsh' ]] || source '/home/apechinsky/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
