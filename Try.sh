#!/bin/bash

#VARIABLES
REPO_NAME=first.git
ORIGIN_URL=git@gitlab.com:ichanism/$REPO_NAME
REPO1_URL=https://github.com/ichanism/$REPO_NAME

#Test flow
rm -rf $REPO_NAME 
git clone --bare $ORIGIN_URL
if [ "$?" != "0" ]; then
  echo "ERROR: failed clone of $ORIGIN_URL"
  exit 1
fi

cd $REPO_NAME
git remote add --mirror=fetch repo1 $REPO1_URL
if [ "$?" != "0" ]; then
  echo "ERROR: failed add remote of $REPO1_URL"
  exit 1
fi

git fetch origin --tags
if [ "$?" != "0" ]; then
  echo "ERROR: failed fetch from $ORIGIN_URL"
  exit 1
fi

git fetch repo1 --tags
if [ "$?" != "0" ]; then
  echo "ERROR: failed fetch from $REPO1_URL"
  exit 1
fi

git push origin --all
if [ "$?" != "0" ]; then
  echo "ERROR: failed push to $ORIGIN_URL"
  exit 1
fi

git push origin --tags
if [ "$?" != "0" ]; then
  echo "ERROR: failed push tags to $ORIGIN_URL"
  exit 1
fi

git push repo1 --all
if [ "$?" != "0" ]; then
  echo "ERROR: failed push to $REPO1_URL"
  exit 1
fi

git push repo1 --tags
if [ "$?" != "0" ]; then
  echo "ERROR: failed push tags to $REPO1_URL"
  exit 1
fi
