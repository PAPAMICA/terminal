#!/bin/bash

# Active Verbose & Help
VERBOSE="> /dev/null 2> /dev/null"
MOTD=0
ALLUSERS=0
for argument in "$@"; do
    if [ -n "$argument" ]; then
        if [ $argument == "--verbose" ]; then
            echo " ✅ Verbose selected"
            VERBOSE=" "   
        elif [ $argument == "--help" ]; then
            echo 'This script installs differents tools for the Shell (Check https://github.com/PAPAMICA/terminal).
        Use "--verbose" to display the logs
        Use "--motd" to update your motd
        Use "--all-users" to apply all modifications to alls users'
            exit
        elif [ $argument == "--motd" ]; then
            echo " ✅ MOTD selected"
            MOTD=1
        elif [ $argument == "--all-users" ]; then
            echo " ✅ All users selected"
            ALLUSERS=1
        else
            echo "This argument is not recognized ($argument)"
            exit
        fi
    fi
done


# Check if Debian / Ubuntu and if root
if [ "$EUID" -ne 0 ]
  then echo " ❌ Please run as root"
  exit
fi
if [ -x "$(command -v apt-get)" ]; then
    :
else
    echo 'This script is only compatible with Debian and Ubuntu'
    exit
fi

# Update System
echo ""
echo "-- Update  --"
eval apt-get update $VERBOSE
UPGRADE=$(apt update 2>/dev/null | tail -1)
echo " ℹ️  $UPGRADE"




# Installation
## Requierements
apt_install () {
    eval apt-get install -y $1 $VERBOSE
    if [ $? -eq 0 ]; then
        echo "   ($i/8) ✅ $1"
    else
        echo "   ($i/8) ❌ $1"
    fi
}

copy_to_usershome () {
    _USERS="$(awk -F':' '{ if ( $3 >= 500 ) print $1 }' /etc/passwd)"
    FOLDERSOURCE=$1
    FOLDERDESTINATION=$2
    for _USER in $_USERS; do
        _DIR="/home/${_USER}"
        if [ -d "$_DIR" ]; then
            mkdir -p $_DIR/$FOLDERDESTINATION
            echo " ✅ $FOLDERSOURCE copied to $_USER home !"
            /bin/cp -r "$FOLDERSOURCE" "$_DIR/$FOLDERDESTINATION"
            chown -R $(id -un $_USER):$(id -gn $_USER) "$_DIR"
        fi
    done
}

zsh_all_users () {
    _USERS="$(awk -F':' '{ if ( $3 >= 500 ) print $1 }' /etc/passwd)"
    for _USER in $_USERS; do
        _DIR="/home/${_USER}"
        if [ -d "$_DIR" ]; then
            chsh --shell /bin/zsh $_USER
        fi
    done
}

echo ""
echo "-- Requirements --"
echo " 🤖 Installing $1 ..."
PACKAGES="curl wget gzip lsb-release locales pip make bzip2"
i=0
for PACKAGE in $PACKAGES; do
    i=$((i+1))
    apt_install $PACKAGE
done
echo " ✅ All requirements have been installed  !"

if [[ "$MOTD" == 1 ]]; then
    echo ""
    echo "-- MOTD --"
    echo " 🤖 Installing  MOTD..."
    eval apt-get install -y neofetch figlet $VERBOSE
    mkdir -p /root/.config/neofetch && touch /root/.config/neofetch/config.conf
    curl -s https://raw.githubusercontent.com/PAPAMICA/terminal/main/neofetch.conf > /root/.config/neofetch/config.conf
    mkdir -p /etc/neofetch && touch /etc/neofetch/config.conf
    curl -s https://raw.githubusercontent.com/PAPAMICA/terminal/main/neofetch.conf > /etc/neofetch/config.conf
    if [[ "$ALLUSERS" == 1 ]]; then
        copy_to_usershome /root/.config/neofetch/ .config
    fi
    rm -rf /etc/motd /etc/update-motd.d/*
    touch /etc/update-motd.d/00-motd && chmod +x /etc/update-motd.d/00-motd
    echo "#!/bin/sh
#By Mickael (PAPAMICA) Asseline
figlet $(uname -n | cut -d '.' -f 1)
neofetch --config /etc/neofetch/config.conf" >> /etc/update-motd.d/00-motd
    echo " ✅ MOTD have been configured !"
fi
    


## Applications
app_install () {
    echo ""
    echo "-- $app --"
    if [ -x "$(command -v $app)" ]; then
        echo " ✅ $app is already installed !"
    else
        echo " 🤖 Installing $app ..."
        eval "$install"
        if [ $? -eq 0 ]; then
            if [ -n "$zshrc" ]; then
                echo ''  >> ~/.zshrc
                echo "# $app" >> ~/.zshrc
                echo "$zshrc" >> ~/.zshrc
                echo " ✅ .zshrc updated !"
            fi
            echo " ✅ $app have been installed !"
        else
            echo " ❌ $app can't be installed ! ($?)"
        fi
        
    fi

}

## git
app='git'
install='apt-get install -y git '$VERBOSE''
zshrc="gic() { eval 'git add . && git commit -a -m \"'\$@'\" && git push'}
alias gaa=\"git add *\"
alias ga=\"git add\"
alias gps=\"git push\"
alias gpl=\"git pull\""
app_install $app $install $zshrc

## zsh
app='zsh'
install='apt-get install -y zsh '$VERBOSE' && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended '$VERBOSE' && \
sed -i -e "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME="agnoster"/g" ~/.zshrc '$VERBOSE''
zshrc=''
app_install $app $install $zshrc

## ad
app='ad'
install='pip3 install advance-touch '$VERBOSE''
zshrc='alias add="python3 ~/Library/Python/3.9/lib/python/site-packages/advance_touch.py"'
app_install $app $install $zshrc

## atuin
app='atuin'
install='bash -c "$(curl -s https://raw.githubusercontent.com/ellie/atuin/main/install.sh)" '$VERBOSE' && \
atuin import auto '$VERBOSE''
zshrc='eval "$(atuin init zsh)"'
app_install $app $install $zshrc

## bat
app='batcat'
install='apt-get install -y bat '$VERBOSE''
zshrc="alias cat='batcat --style=\"header\" --paging=never'
alias bat='batcat --style=\"header\" --paging=never'
alias catn='batcat --pager \"less -RF\"'
alias batn='batcat --pager \"less -RF\"'"
app_install $app $install $zshrc

## btop
app='btop'
install='mkdir btop && cd btop && \
curl -s https://api.github.com/repos/aristocratos/btop/releases/latest \
| grep "browser_download_url.*btop-x86_64-linux-musl.tbz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - && \
tar -xf btop-x86_64-linux-musl.tbz '$VERBOSE' && \
make install '$VERBOSE' && cd .. && rm -rf btop'
zshrc='alias top="btop --utf-force"
alias btop="btop --utf-force"
alias htop="btop --utf-force"'
app_install $app $install $zshrc

## cheat
app='cheat'
install='curl -s https://api.github.com/repos/cheat/cheat/releases/latest \
| grep "browser_download_url.*cheat-linux-amd64.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - && \chdea
gzip -d cheat-linux-amd64.gz '$VERBOSE' && \
chmod +x cheat-linux-amd64 && mv cheat-linux-amd64 /usr/local/bin/cheat && rm -rf cheat-linux-amd64* && \
git clone https://github.com/PAPAMICA/cheatsheets.git ~/.config/cheat/cheatsheets/papamica/ '$VERBOSE' && \
curl -s "https://raw.githubusercontent.com/PAPAMICA/terminal/main/cheat_conf.yml" >> ~/.config/cheat/conf.yml && \
curl -s "https://raw.githubusercontent.com/PAPAMICA/terminal/main/cheat_autocomplete.zsh" >> ~/.oh-my-zsh/custom/cheat.zsh && \ 
mkdir ~/.config/cheat/cheatsheets/personal/'
zshrc="alias \"?\"=\"cheat\"
alias \"??\"=\"cheat perso\"
alias cheat-update='git -C ~/.config/cheat/cheatsheets/papamica/ pull > /dev/null 2> /dev/null && echo \" ✅ Cheats updated !\"'"
app_install $app $install $zshrc

## direnv
app='direnv'
install='apt install -y direnv '$VERBOSE''
zshrc='eval "$(direnv hook zsh)"'
app_install $app $install $zshrc

## duf
app='duf'
install='curl -s https://api.github.com/repos/muesli/duf/releases/latest \
| grep "browser_download_url.*amd64.deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - && \
dpkg -i duf*.deb '$VERBOSE' && rm duf*.deb '$VERBOSE''
zshrc=''
app_install $app $install $zshrc

## exa
app='exa'
install='apt install -y exa '$VERBOSE''
zshrc='alias ls="exa -a --icons"         # short, multi-line
alias ll="exa -1a --icons"        # list, 1 per line
alias ld="ll"             # ^^^, NOTE: Trying to move to this for alternate hand commands
alias la="exa -lagh --icons"        # list with info
alias lt="exa -a --tree --icons --level=2"        # list with tree level 2
alias ltf="exa -a --tree --icons"        # list with tree
alias lat="exa -lagh --tree --icons"        # list with info and tree'
app_install $app $install $zshrc

## fd
app='fdfind'
install='apt install -y fd-find '$VERBOSE''
zshrc='alias locate="fdfind"
alias find="fdfind"'
app_install $app $install $zshrc

## fuck
app='fuck'
install='pip3 install thefuck  '$VERBOSE''
zshrc='eval $(thefuck --alias)'
app_install $app $install $zshrc

## micro
app='micro'
install='su - root -c "cd /usr/bin; wget -O- https://getmic.ro | GETMICRO_REGISTER=y sh; cd ~" '$VERBOSE''
zshrc=''
app_install $app $install $zshrc

## ripgrep
app='rg'
install='curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest \
| grep "browser_download_url.*amd64.deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - && \
dpkg -i ripgrep*.deb '$VERBOSE' && rm ripgrep*.deb '$VERBOSE''
zshrc='alias grep="rg"'
app_install $app $install $zshrc

## z
app='z'
install='git clone https://github.com/rupa/z.git /bin/z '$VERBOSE''
zshrc='. /bin/z/z.sh'
app_install $app $install $zshrc

## zsh_autoggestions
app='zsh_autoggestions'
install='git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions '$VERBOSE''
zshrc='source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"'
app_install $app $install $zshrc

## zsh_syntax_highlighting
app='zsh_syntax_highlighting'
install='git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting '$VERBOSE''
zshrc='source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
app_install $app $install $zshrc

## Copy to others users
if [[ "$ALLUSERS" == 1 ]]; then
    echo ""
    echo "-- OTHERS USERS --"
    copy_to_usershome /root/.config/cheat .config
    copy_to_usershome /root/.oh-my-zsh .
    copy_to_usershome /root/.zsh .
    copy_to_usershome /root/.zshrc .
    zsh_all_users
fi

chsh --shell /bin/zsh root
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
zsh