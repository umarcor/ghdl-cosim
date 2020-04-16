#!/usr/bin/env sh

cd "$(dirname $0)"

set -e


echo "Analyze tb.vhd"
ghdl -a tb.vhd

echo "Build tb (with main.c)"
ghdl -e -Wl,main.c tb

echo "Execute tb"
./tb
