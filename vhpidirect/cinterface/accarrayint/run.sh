#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze pkg.vhd tb.vhd"
ghdl -a pkg.vhd tb.vhd

echo "Build tb (with caux.c) [GHDL]"
ghdl -e -Wl,caux.c tb

echo "Execute tb"
./tb

