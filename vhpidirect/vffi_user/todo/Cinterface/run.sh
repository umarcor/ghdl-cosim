#!/usr/bin/env sh

set -e

ghdl -a -O0 -g tb.vhd
ghdl -e -O0 -g -Wl,-I./ -Wl,main.c -o tb tb
./tb
