#!/usr/bin/bash

mtype=$(file --mime-type $1 | awk '{print $NF}')
mdef=$(xdg-mime query default $mtype)

echo "type    : $mtype"
echo "default : $mdef"
echo "set with: xdg-mime default APP.desktop $mtype"
