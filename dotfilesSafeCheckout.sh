#!/usr/bin/bash
# https://www.atlassian.com/git/tutorials/dotfiles

bakDir=$HOME/computer/dotfiles/bak
dotDir=$HOME/.dotfiles.git

[ -d $bakDir ] || mkdir -p $bakDir


function dotfiles {
  /usr/bin/git --git-dir=$dotDir --work-tree=$HOME $@
}

dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dotfiles.";
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $bakDir/{}
  dotfiles checkout
fi
