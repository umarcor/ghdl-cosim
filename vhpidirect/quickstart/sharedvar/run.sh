#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "VHDL 93: Analyze pkg_93.vhd ent.vhd tb.vhd"
ghdl -a --std=93 pkg_93.vhd ent.vhd tb.vhd

echo "Build tb_93 with main.c"
ghdl -e --std=93 -Wl,main.c -o tb_93 tb

echo "Execute tb_93"
./tb_93
