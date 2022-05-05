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
alias la="exa -lagh --icons"                  # list with info
alias lt="exa -a --tree --icons --level=2"  # list with tree level 2
alias ltf="exa -a --tree --icons"           # list with tree
alias lat="exa -lagh --tree --icons"          # list with info and tree

# fd
alias locate="fdfind"
alias find="fdfind"

# fuck
eval $(thefuck --alias)

# git
gic() { eval 'git add . && git commit -a -m "'$@'" && git push'}
gbc() { eval 'git pull && git checkout -b '$@' && git push --set-upstream origin '$@''}
gweb() { git remote -v | head -n 1 | awk -F "@" '{print $2}' | awk -F " " '{print $1}' | sed 's/:/\//g' | sed 's/.git//g' | awk '{print "http://"$1}' | xargs open }
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

# ripgrep
alias grep="rg"

# z
. /bin/z/z.sh

# zsh_autocompletion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"

# zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
