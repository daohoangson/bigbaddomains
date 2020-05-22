#!/bin/sh

set -e

cp -R ./list ./public/list

cat ./list/*.txt >./public/all.txt

ls -al ./public
