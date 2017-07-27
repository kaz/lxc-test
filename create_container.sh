lxc-create -n test -t download -- -d archlinux -r current -a amd64
sed -Ei "s/(172\.16\.0\.)[0-9]+/\12/" /var/lib/lxc/test/config 
echo "nameserver 172.16.0.1" > /var/lib/lxc/test/rootfs/etc/resolv.conf
lxc-start -n test
