#!/bin/sh

set -eu

if [ "$#" -ne 1 ] || [ -z "$1" ]; then
  echo "Usage: $0 <output-directory>" >&2
  exit 1
fi

_target=$1
_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

if [ ! -d "$_target" ]; then
  mkdir -p "$_target"
fi

cp -R "$_root/list" "$_target/."

LC_ALL=C sort "$_root"/list/*.txt > "$_target/all.txt"
cat "$_target/all.txt"

ls -al "$_target"
