#!/usr/bin/env sh

CURRENT_BRANCH=`git branch | grep "\*" | cut -c 3-`
echo ${CURRENT_BRANCH}
git stash
git checkout development
git fetch --prune
git pull
git checkout ${CURRENT_BRANCH}
git stash apply
git merge development
