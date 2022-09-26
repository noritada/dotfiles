#!/bin/sh

cat ./extensions | while read line
do
  codium --install-extension $line
done
