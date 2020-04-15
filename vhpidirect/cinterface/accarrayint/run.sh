#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze pkg.vhd tb.vhd"
ghdl -a pkg.vhd tb.vhd

echo "Build tb (with co-op.c) [GHDL]"
ghdl -e -Wl,co-op.c tb

echo "Execute tb"
./tb

