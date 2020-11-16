#!/usr/bin/bash

## not working (manually connect):
# AM61='E0:9D:FA:24:EA:38'
# pair="power on\ntrust $AM61\npair $AM61\n" 
# conn="power on\nconnect $AM61\n" 
# 
# #echo -e $conn | bluetoothctl
# 
# bluetoothctl <<EOF
# power on
# trust $AM61
# connect $AM61
# EOF

blueman_procs() {
  ps aux | grep blueman | grep -v grep | awk '{print $2}'
}

list_blueman_procs() {
  echo $1
  ps aux | grep blueman | grep -v grep | awk '{ for (i=11; i<=NF; i++) printf "%s ", $(i); printf ": %d\n", $2}'
}

kill_blueman_procs() {
  list_blueman_procs 'blueman procs found:'
  read -p 'Proceed? [y/n] ' proceed

  if [ "$proceed" == "y" ]; then
    bprocs=$(blueman_procs)
    for p in $bprocs; do
      kill $p
    done

    bprocs=$(blueman_procs)
    [[ -n $bprocs ]] && echo 'blueman kill failed' && exit 1
    echo 'blueman killed'
  fi
}

kill_blue() {
  kill_blueman_procs  
  active=$(systemctl is-active bluetooth.service)
  [ "$active" == "active" ] && echo 'killing service...' && systemctl stop bluetooth.service
}

start_blue() {
  active=$(systemctl is-active bluetooth.service)
  [ "$active" == "inactive" ] && echo 'starting service...' && systemctl start bluetooth.service

  bprocs=$(blueman_procs)
  # [[ -n $bprocs ]] && list_blueman_procs 'alerady running:' && exit 1
  [[ -z $bprocs ]] && blueman-manager &
}

restart_blue() {
  kill_blueman_procs  
  echo 'restarting service...' && systemctl restart bluetooth.service
}

toggle_blue() {
  # decide according to blueman
  bprocs=$(blueman_procs)
  if [[ -z $bprocs ]]; then
    start_blue
  else
    kill_blue
  fi
}

case $1 in
  "-k") kill_blue;;
  "-s") start_blue;;
  "-r") restart_blue;;
  *) toggle_blue;;
esac
