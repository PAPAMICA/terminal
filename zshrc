# ZSHRC By Mickael "PAPAMICA" Asseline
# Environement : MACOS


### POWER10K
# https://github.com/romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=off


### ALIAS POUR LA YUBIKEY
# https://github.com/drduh/YubiKey-Guide
alias ssh="gpg-connect-agent updatestartuptty /bye > /dev/null; ssh"
alias scp="gpg-connect-agent updatestartuptty /bye > /dev/null; scp"s
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)


### PLUGINS ZSH
# ZSH-AUTOSUGGESTIONS : https://github.com/zsh-users/zsh-autosuggestions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH-SYNTAX-HIGHLIGHTING : https://github.com/zsh-users/zsh-syntax-highlighting
plugins=(zsh-syntax-highlighting)

### ATUIN
# https://github.com/ellie/atuin
eval "$(atuin init zsh)"


### FUCK
# https://github.com/nvbn/thefuck
eval $(thefuck --alias)


### Z
# https://github.com/rupa/z
. /usr/local/etc/profile.d/z.sh


### FZF
# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


### DIRENV
# https://direnv.net/
eval "$(direnv hook zsh)"


### EXA
# https://the.exa.website/
alias ls="exa -a"           # short, multi-line
alias ll="exa -1a"          # list, 1 per line
alias ld="ll"                   # ^^^, NOTE: Trying to move to this for alternate hand commands
alias la="exa -lah"        # list w/ info


### FD
# https://github.com/sharkdp/fd
alias locate="fd"
alias find="fd"


### NAVI
# https://github.com/denisidoro/navi
alias "?"="navi"
alias help="navi"


### SHELL HISTORY
# https://github.com/pawamoy/shell-history
#if [[ $- == *i* ]] && command -v shellhistory-location &>/dev/null; then
#    . $(shellhistory-location)
#    shellhistory enable
#fi


### AD
# https://github.com/tanrax/terminal-AdvancedNewFile
alias add="python3 ~/Library/Python/3.9/lib/python/site-packages/advance_touch.py"

### RACCOURCIS
alias docker="sudo docker"
alias w="watch "
alias nano="micro"
alias swift="/usr/local/bin/swift"

### Debian environnment
#
alias debian="~/kDrive/TeamBlue/environments/debian/debian.sh"


### TIPEE
# (Voir projet interne Infomaniak)
export TIPEE_USERNAME=''
export TIPEE_PASSWORD=''
alias tipee="python3 ~/Documents/python-tipee/ti.py"


### OTHERS
export OPENCV_LOG_LEVEL=ERROR
export DEFAULT_USER=papamica


### OpenStack
alias openstack-delete-all="openstack server list | awk '$2 && $2 != \"ID\" {print $2}' | xargs -n1 openstack server delete"
alias openstack="openstack --os-compute-api-version 2.79"
alias osl="openstack --os-compute-api-version 2.79 server list --fit-width"
o() { openstack --os-compute-api-version 2.79 "$@" --fit-width ;}
oss() { openstack --os-compute-api-version 2.79 server show "$@" --fit-width ;}
