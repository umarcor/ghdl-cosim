#!/usr/bin/env sh

cd "$(dirname $0)"

set -e

ghdl -a tb.vhd
ghdl -e -Wl,main.c tb
./tb