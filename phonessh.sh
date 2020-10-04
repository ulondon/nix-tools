#!/usr/bin/bash
# https://play.google.com/store/apps/details?id=com.theolivetree.sshserver&hl=en_US

server=myphone
user=ssh # user by app Ssh server, The Olive Tree
port=2222
opt="-oHostKeyAlgorithms=+ssh-dss"

mount_point=/home/urisan/tmp/mntRedmi
# mount_target=/sdcard
mount_target=/storage/emulated/0

[ "$1" == "-d" ] && fusermount3 -u $mount_point && exit 0
sshfs $user@$server:$mount_target $mount_point -p $port $opt
