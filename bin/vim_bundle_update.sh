#!/bin/bash

cd ~/.vim/bundle || exit
for i in $(find . -type d -depth 1);
do
  echo -e "\n$i"
  cd $i
  git pull
  cd -
done
