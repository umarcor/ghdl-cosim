#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze tb.vhd"
ghdl -a cAccess.vhd tb.vhd

echo "Build tb (with cSharedVar.c) [GHDL]"
ghdl -e -Wl,cSharedVar.c tb

echo "Execute tb"
./tb

