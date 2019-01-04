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
plugins=(git adb docker history-substring-search spring jira themes zsh-wakatime)

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

. $HOME/_environment/env.sh

set +o noclobber
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "/home/apechinsky/.sdkman/bin/sdkman-init.sh" ]] && source "/home/apechinsky/.sdkman/bin/sdkman-init.sh"

# CSREPO tool initialization
export CSREPO_HOME="/home/apechinsky/.csrepo"
[[ -s "/home/apechinsky/.csrepo/bin/csrepo" ]] && export PATH=/home/apechinsky/.sdkman/candidates/lazybones/current/bin:/home/apechinsky/.sdkman/candidates/kscript/current/bin:/home/apechinsky/.sdkman/candidates/java/current/bin:/home/apechinsky/.sdkman/candidates/groovy/current/bin:/home/apechinsky/.sdkman/candidates/gradle/current/bin:/home/apechinsky/.sdkman/candidates/asciidoctorj/current/bin::/opt/java/jdk-1.8.0_153-linux64/bin:/opt/java/yajsw-11.03/bin:/opt/java/pmd-bin-5.5.1/bin:/opt/java/androidsdk-linux/tools:/opt/java/androidsdk-linux/platform-tools:/opt/java/android-studio-2.2.2.0/bin:/opt/java/wildfly-8.2.0.Final/bin:/opt/java/dex2jar-0.0.9.12:/opt/java/appengine-java-sdk-1.7.2.1/bin:/opt/java/findbugs-2.0.2/bin:/opt/java/logstash-1.4.2/bin:/opt/java/elasticsearch-1.1.1/bin:/opt/java/apache-jmeter-2.13/bin:/opt/openxenmanager:/opt/viber::/opt/java/jdk-1.8.0_153-linux64/bin:/opt/java/yajsw-11.03/bin:/opt/java/pmd-bin-5.5.1/bin:/opt/java/androidsdk-linux/tools:/opt/java/androidsdk-linux/platform-tools:/opt/java/android-studio-2.2.2.0/bin:/opt/java/wildfly-8.2.0.Final/bin:/opt/java/dex2jar-0.0.9.12:/opt/java/appengine-java-sdk-1.7.2.1/bin:/opt/java/findbugs-2.0.2/bin:/opt/java/logstash-1.4.2/bin:/opt/java/elasticsearch-1.1.1/bin:/opt/java/apache-jmeter-2.13/bin:/opt/openxenmanager:/opt/viber:/home/apechinsky/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/apechinsky/.csrepo/bin
