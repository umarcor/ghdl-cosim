#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "> Analyze tb.vhd"
ghdl -a tb.vhd


echo "> Build tb (with rawargs.c)"
ghdl -e -Wl,rawargs.c -o tb_rawargs tb

echo "> Execute tb_rawargs"
./tb_rawargs


echo "> Build tb (with procargs.c)"
ghdl -e -Wl,procargs.c -o tb_procargs tb

echo "> Execute tb_procargs"
./tb_procargs


echo "> Build tb (with fcnargs.c)"
ghdl -e -Wl,fcnargs.c -o tb_fcnargs tb

echo "> Execute tb_fcnargs"
./tb_fcnargs


echo "> Build tb (with separgs.c)"
ghdl -e -Wl,separgs.c -o tb_separgs tb

echo "> Execute tb_separgs"
./tb_separgs
