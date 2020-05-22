#!/bin/sh

set -e

_target=$1

if [ ! -d "$_target" ]; then
  mkdir -p "$_target"
fi

cp -R ./list "$_target/."

cat ./list/*.txt >"$_target/all.txt"

ls -al "$_target"
