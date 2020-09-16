#!/usr/bin/env sh

set -e

cd $(dirname "$0")/"$1"

ghdl -a -O0 -g tb.vhd
ghdl -e -O0 -g -Wl,-I./ -Wl,main.c tb
./tb
