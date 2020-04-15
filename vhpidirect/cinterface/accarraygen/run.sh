#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze cAccess.vhd and tb.vhd"
ghdl -a --std=08 cAccess.vhd tb.vhd

echo "Build tb (with main.c) [GHDL]"
ghdl -e -Wl,main.c --std=08 tb

echo "Execute tb (-gArraySize=5)"
./tb -gArraySize=5

