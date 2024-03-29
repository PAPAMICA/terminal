<p align="center">
  <a href="https://papamica.com">
    <img src="https://img.papamica.com/logo/papamica.png" width="140px" alt="PAPAMICA" />
  </a>
</p>

<p align="center">
  <a href="#"><img src="https://readme-typing-svg.herokuapp.com?center=true&vCenter=true&lines=My+terminal;"></a>
</p>
<p align="center">
    Update : 2022/05/12<br />
    Article Tech2Tech (in French) : https://ppmc.me/t2t-terminal
</p>
<p align="center">
    <a href="https://github.com/PAPAMICA/container-updater#packages"><img src="https://img.shields.io/badge/Packages-%2341454A.svg?style=for-the-badge&logo=target&logoColor=white"> </a>
    <a href="https://github.com/PAPAMICA/terminal#%EF%B8%8F-install-script-for-debian--ubuntu-server"><img src="https://img.shields.io/badge/Install_script_for_debian-%2341454A.svg?style=for-the-badge&logo=target&logoColor=white"> </a>
    <a href="https://github.com/PAPAMICA/terminal#-debian-environment"><img src="https://img.shields.io/badge/Debian_VM-%2341454A.svg?style=for-the-badge&logo=target&logoColor=white"> </a>
    <br /><br />
    <a href="#"><img src="https://img.shields.io/badge/bash-%23CDCDCE.svg?style=for-the-badge&logo=gnubash&logoColor=1B1B1F"> </a>
    <a href="https://www.debian.org/index.fr.html"><img src="https://img.shields.io/badge/Debian-%23A81D33.svg?style=for-the-badge&logo=debian&logoColor=white"> </a>
    <a href="#"><img src="https://img.shields.io/badge/macos-%23000000.svg?style=for-the-badge&logo=apple&logoColor=white"> </a>
    <br />
</p> 


## ⚡️ Informations
**Operating System :** MacOS Monterey

**Terminal Client :** [Tabby](https://tabby.sh/)

**Text Editor :** [Micro](https://micro-editor.github.io/)

## 📦️ Packages

 - [ad](https://github.com/tanrax/terminal-AdvancedNewFile) : Create folders and files easily
 - [atuin](https://github.com/ellie/atuin) : Manage your commands history
 - [bat](https://github.com/sharkdp/bat) : Better `cat`
 - [btop](https://github.com/aristocratos/btop) : Better `htop`
 - [cheat](https://github.com/cheat/cheat) : Better `man`, all your cheatsheet in your terminal (Check [PAPAMICA/cheatsheets](https://github.com/PAPAMICA/cheatsheets))
 - [dog](https://github.com/ogham/dog) : Better `dig`
 - [direnv](https://direnv.net/) : Set up environment variables based on the folder
 - [duf](https://github.com/muesli/duf) : Better `df -h`with graphics (Thx [@Lucroz94](https://github.com/Lucroz94))
 - [exa](https://the.exa.website/) : Improving the `ls` command
 - [fd](https://github.com/sharkdp/fd) : Boost the `find` command
 - [fig](https://github.com/withfig/autocomplete) : Popup with subcommands and options
 - [fuck](https://github.com/nvbn/thefuck) : Fuck! I missed my command ! 
 - [navi](https://github.com/denisidoro/navi) :  The manual of manuals
 - [ncdu](https://dev.yorhel.nl/ncdu) : Display your storage simply and graphically
 - [oh-my-zsh](https://ohmyz.sh/) : Making zsh pretty
 - [power10k](https://github.com/romkatv/powerlevel10k) : Customize your command prompt to perfection
 - [progress](https://github.com/Xfennec/progress) : Monitor the progress of multiple commands
 - [ripgrep](https://github.com/BurntSushi/ripgrep) : Better `grep`
 - [z](https://github.com/rupa/z) : Get to your folders as quickly as possible
 - [zsh](https://www.zsh.org/) : More intuitive than bash
 - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) : Like fish
 - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) : Like fish too


## ⚙️ Install script for Debian / Ubuntu server

```bash
bash -c "$(curl -s https://raw.githubusercontent.com/PAPAMICA/terminal/main/server_utils.sh)"
```

You can add a dynamic MOTD (with neofetch) with `--motd`:
```bash
curl -Ls https://raw.githubusercontent.com/PAPAMICA/terminal/main/server_utils.sh | bash -s -- --motd
```

You can apply all modifications to all users with `--all-users`:
```bash
curl -Ls https://raw.githubusercontent.com/PAPAMICA/terminal/main/server_utils.sh | bash -s -- --all-users
```

You can display all logs with `--verbose`:
```bash
curl -Ls https://raw.githubusercontent.com/PAPAMICA/terminal/main/server_utils.sh | bash -s -- --verbose
```

You can display help with `--help`:
```bash
curl -Ls https://raw.githubusercontent.com/PAPAMICA/terminal/main/server_utils.sh | bash -s -- --help
```

If you want an oneliner for motd, all-users and you don't have curl installed :
```bash
apt update && apt install -y curl && curl -Ls https://raw.githubusercontent.com/PAPAMICA/terminal/main/server_utils.sh | bash -s -- --motd --all-users
```
## 🔨 Debian environment
I work on MacOS, but sometimes I need to run some scripts in Debian directly.. So .. I have scripted that !

### Requirements
 - VirtualBox
 - VBoxmanage
 - Create a VM
 - Redirect 2222 port to SSH
 - Docker (if you use `temp` option)

### Commands
- `stop`
- `list <snaps/vms>`
- `rollback`
- `restore <snap_name>`
- `delete`
- `temp`
