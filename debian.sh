#!/bin/bash
# Gérer une VM Debian depuis son terminal en une commande.
# Prérequis : VirtualBox / VBoxManage / Créer une VM / Rediriger le port 2222 vers le port SSH
# Pour la version temporaire : Docker / Docker-Compose
# Commandes disponibles : stop / list <snaps/vms> / rollback / restore <snap> / delete / temp

VM=Debian
SSH_PASSWORD=''
snapshot_folder=''

if [[ $1 == "stop" ]]; then
  VBoxManage controlvm "$VM" poweroff --type headless
  elif [[ $1 == "snap" ]]; then
    if [ -z $2 ]; then
      echo "Provide a name for your snapshot ! ($VM snap <name>)"
      exit
    fi
    name=$2
    VBoxManage snapshot $VM take $name
  elif [[ $1 == "list" ]]; then
    if [[ $2 == "snaps" ]]; then
      VBoxManage snapshot $VM list
    elif [[ $2 == "vms" ]]; then
      VBoxManage list vms
    fi
  elif [[ $1 == "rollback" ]]; then
    VBoxManage controlvm "$VM" poweroff --type headless
    VBoxManage snapshot $VM restorecurrent
  elif [[ $1 == "restore" ]]; then
    if [ -z $2 ]; then
      echo "Provide a name for your snapshot ! ($VM restore <name>)"
      exit
    fi
    name=$2
    VBoxManage controlvm "$VM" poweroff --type headless
    VBoxManage snapshot $VM restore $name
  elif [[ $1 == "delete" ]]; then
    if [ -z $2 ]; then
      echo "Provide a name for your snapshot ! ($VM delete <name>)"
      exit
    fi
    name=$2
    VBoxManage snapshot $VM delete $name
  elif [[ $1 == "temp" ]]; then
    sudo docker run -v $HOME:/root -it debian bash
  else
    RUNNING=$(VBoxManage list runningvms | awk '{print $1}' )
    if [ -z $RUNNING ]; then
    VBoxManage startvm "$VM" --type headless
    fi
    sshpass -p $SSH_PASSWORD ssh -A -p 2222 root@127.0.0.1
fi
