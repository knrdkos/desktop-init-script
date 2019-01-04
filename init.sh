#!/bin/bash

if [ ! "`whoami`" = "root" ]
then
    echo "Please run script as root."
    exit 1
fi

echo "Sit back and relax, this will take some time."
echo "If You've used command from github, system should reboot after succesfull execution of this script. If not, please reboot it manually"

REPO_NAME=desktop-init-script

add-apt-repository -y ppa:papirus/papirus
add-apt-repository -y ppa:webupd8team/java
apt update && apt upgrade -y

apt install -y zim keepassx arc-theme papirus-icon-theme i3lock vim wmctrl \
	scrot xclip htop steam linux-tools-common parcellite linux-tools-generic \
       	network-manager-openvpn-gnome neofetch vlc gnome-disk-utility stress maven \
       	git docker.io xfce4-goodies

gpasswd -a $SUDO_USER docker

snap install spotify pdftk telegram-desktop
snap install --classic intellij-idea-ultimate

git clone https://github.com/knrdkos/$REPO_NAME.git
mv $REPO_NAME/usr_local_bin/*.sh /usr/local/bin/

XFCE_CONFIG_FOLDER=/home/$SUDO_USER/.config/xfce4

mkdir -p $XFCE_CONFIG_FOLDER/panel && rm -f $XFCE_CONFIG_FOLDER/panel/*
mkdir -p $XFCE_CONFIG_FOLDER/xfconf/xfce-perchannel-xml && rm -f $XFCE_CONFIG_FOLDER/xfconf/xfce-perchannel-xml/*

mv $REPO_NAME/xfce_conf/xfce-perchannel-xml/* $XFCE_CONFIG_FOLDER/xfconf/xfce-perchannel-xml/
mv $REPO_NAME/xfce_conf/panel/*  $XFCE_CONFIG_FOLDER/panel/

echo "alias c='xclip -selection clipboard'" >> /home/$SUDO_USER/.bashrc
mkdir -p /home/$SUDO_USER/.ssh

# silent oracle installation - possibly migrate to openjdk later?
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt install -y oracle-java8-installer

echo "Script will attempt a cleanup and reboot in:"
secs=5
while [ $secs -gt 0 ]; do
   echo -ne "$secs\033[0K\r"
   sleep 1
   : $((secs--))
done


rm -rf $REPO_NAME
