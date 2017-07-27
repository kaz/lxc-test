#!/bin/bash

cp -Tr /vagrant/etc/ /etc

printf "root\nroot" | sudo passwd

timedatectl set-timezone Asia/Tokyo

curl "https://www.archlinux.org/mirrorlist/?country=JP&protocol=http&protocol=https&ip_version=4&use_mirror_status=on" | sed "s/^#//g" > /etc/pacman.d/mirrorlist

pacman --noconfirm -Rdd linux virtualbox-guest-modules-arch
pacman --noconfirm -Syu linux-hardened linux-hardened-headers virtualbox-guest-dkms lxc wget dnsmasq
pacman --noconfirm -Scc

grub-mkconfig -o /boot/grub/grub.cfg

chmod u+s /usr/bin/newuidmap
chmod u+s /usr/bin/newgidmap
echo "root:100000:65536" > /etc/subuid
echo "root:100000:65536" > /etc/subgid

sysctl net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/ipforward.conf

netctl enable lxcbridge
systemctl enable dnsmasq
systemctl enable iptables

systemctl reboot
