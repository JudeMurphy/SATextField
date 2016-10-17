#!/bin/bash
git add -A

if [ -z "$1" ]
  then
    git commit -m "Automated Commit"
  else
  	git commit -m $1
fi

git push
clear
git status