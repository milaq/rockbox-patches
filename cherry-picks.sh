#!/bin/bash

function check_clean {
  if [ -e *.patch ]
  then
    rm *.patch
  fi
  if [ -e ".git/rebase-apply" ]
  then
    git am --abort
    exit 1
  elif [ -e ".git/CHERRY_PICK_HEAD" ]
  then
    git cherry-pick --abort
    exit 1
  fi
}

function apply {
  echo "Getting: $1"
  wget -q https://raw.githubusercontent.com/milaq/rockbox-patches/master/patches/$1.patch
  git am $1.patch
  check_clean
}

#################################################################

# separators: modify 'auto' to draw only the title line
apply separators
