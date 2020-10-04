#!/usr/bin/bash

AM61='E0:9D:FA:24:EA:38'
pair="power on\ntrust $AM61\npair $AM61\n" 
conn="power on\nconnect $AM61\n" 

#echo -e $conn | bluetoothctl

bluetoothctl <<EOF
power on
trust $AM61
connect $AM61
EOF
