#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze cAccess.vhd ent1.vhd ent2.vhd tb.vhd"
ghdl -a cAccess.vhd ent1.vhd ent2.vhd tb.vhd

echo "Compile cSharedVar.o"
gcc -c cSharedVar.c -o cSharedVar.o

echo "Build tb with cSharedVar.o"
ghdl -e -Wl,cSharedVar.o tb

echo "Execute tb"
./tb
