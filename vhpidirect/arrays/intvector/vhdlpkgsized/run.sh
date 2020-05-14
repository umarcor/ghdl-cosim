#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "> Analyze pkg.vhd and tb.vhd"
ghdl -a --std=08 pkg.vhd tb.vhd

echo "> Build tb (with vhdlsized/caux.c) [GHDL]"
ghdl -e --std=08 -Wl,../vhdlsized/caux.c tb

echo "> Execute tb (-gArraySize=3)"
./tb -gArraySize=3

echo "> Execute tb (-gArraySize=5)"
./tb -gArraySize=5


echo ""
echo "> Build tb (with caux.c and main.c) [GHDL]"
ghdl -e --std=08 -Wl,../vhdlsized/caux.c -Wl,main.c -o main tb

echo "> Execute main (with --grow-vec 1)"
./main --grow-vec 1

echo "> Execute main (with --grow-vec 2)"
./main --grow-vec 2
