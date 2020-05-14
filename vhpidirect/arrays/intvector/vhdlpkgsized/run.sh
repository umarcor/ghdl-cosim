#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "> Analyze pkg.vhd and tb.vhd"
ghdl -a --std=08 pkg.vhd tb.vhd

echo "> Build tb (with caux.c) [GHDL]"
ghdl -e -Wl,caux.c --std=08 tb

echo "> Execute tb (-gArraySize=3)"
./tb -gArraySize=3

echo "> Execute tb (-gArraySize=5)"
./tb -gArraySize=5


echo ""
echo "> Build tb (with caux.c and main.c) [GHDL]"
ghdl -e -Wl,caux.c -Wl,main.c --std=08 -o main tb

echo "> Execute main (with --grow-vec 1)"
./main --grow-vec 1

echo "> Execute main (with --grow-vec 2)"
./main --grow-vec 2
