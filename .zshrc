#completion
autoload -U compinit
compinit
autoload -U incremental-complete-word
zle -N incremental-complete-word
autoload -U insert-files
zle -N insert-files
autoload -U predict-on
zle -N predict-on

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;35:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:'

zstyle ':completion:*:default' list-colors "$LS_COLORS"
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add-space true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true
zstyle ':completion:*' users {}

setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

#bindkey
bindkey -e
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

#ftp
autoload -U zfinit
zfinit 

#prompt
PROMPT='[%d]$ '
#RPROMPT='<%T>'

#history
HISTFILE=~/.zhistory
SAVEHIST=5000
HISTSIZE=5000
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

#mime types
alias -s {avi,mpeg,mpg,mp4,mov,ogg,mp3,wav,wma}=mplayer
alias -s {djvu,djv,ps,dvi,pdf}=evince
alias -s {odt,doc,sxw,rtf,doc,xls,docx,xlsx}=soffice
alias -s {html,htm,xhtml}=firefox

#web browser
autoload -U pick-web-browser

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias grep='egrep --color'
alias ls='ls -F --color=auto'
alias ll='ls -l --color=auto -h'
alias lla='ls -l -a --color -h'
alias la='ls -a --color'
alias lsd='ls -d *(-/DN) --color'
alias lld='ls -ld *(-/DN) --color'
alias lsa='ls -ld .*'

#. $HOME/_environment/env.sh
. $HOME/.profile


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/apechinsky/.sdkman"
[[ -s "/home/apechinsky/.sdkman/bin/sdkman-init.sh" ]] && source "/home/apechinsky/.sdkman/bin/sdkman-init.sh"
