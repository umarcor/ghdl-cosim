#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze pkg.vhd ent.vhd tb.vhd"
ghdl -a pkg.vhd ent.vhd tb.vhd

echo "Build tb with main.c"
ghdl -e -Wl,main.c tb

echo "Execute tb"
./tb
