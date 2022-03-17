# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=agnoster
plugins=(git)
source $ZSH/oh-my-zsh.sh

# atuin
eval "$(atuin init zsh)"

# ad
alias add="python3 ~/Library/Python/3.9/lib/python/site-packages/advance_touch.py"

# bat
alias cat='batcat --style="header" --paging=never'
alias catn='batcat --pager "less -RF"'
alias batn='batcat --pager "less -RF"'

# btop
alias top="btop --utf-force"
alias btop="btop --utf-force"
alias htop="btop --utf-force"

# cheat
alias "?"="cheat"
alias "??"="cheat perso"
alias cheat-update='git -C ~/.config/cheat/cheatsheets/papamica/ pull > /dev/null 2> /dev/null && echo " ✅ Cheats updated !"'

# direnv
eval "$(direnv hook zsh)"

# exa
alias ls="exa -a --icons"                   # short, multi-line
alias ll="exa -1a --icons"                  # list, 1 per line
alias ld="ll"                               # ^^^, NOTE: Trying to move to this for alternate hand commands
alias la="exa -la --icons"                  # list with info
alias lt="exa -a --tree --icons --level=2"  # list with tree level 2
alias ltf="exa -a --tree --icons"           # list with tree
alias lat="exa -la --tree --icons"          # list with info and tree

# fd
alias locate="fdfind"
alias find="fdfind"

# fuck
eval $(thefuck --alias)

# git
gic() { eval 'git add . && git commit -a -m "'$@'" && git push'}
alias gaa="git add *"
alias ga="git add"
alias gps="git push"
alias gpl="git pull"

# openStack
alias openstack-delete-all="openstack server list | awk '$2 && $2 != \"ID\" {print $2}' | xargs -n1 openstack server delete"
alias openstack="openstack --os-compute-api-version 2.79"
alias osl="openstack --os-compute-api-version 2.79 server list --fit-width"
o() { openstack --os-compute-api-version 2.79 "$@" --fit-width ;}
oss() { openstack --os-compute-api-version 2.79 server show "$@" --fit-width ;}

# z
. /bin/z/z.sh

# zsh_autocompletion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"