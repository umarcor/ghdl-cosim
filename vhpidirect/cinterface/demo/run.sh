#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "Analyze tb.vhd"
ghdl -a -O0 -g tb.vhd

echo "Build tb (with main.c and headers)"
ghdl -e -O0 -g -Wl,-I../../ -Wl,main.c tb

echo "Execute tb"
./tb
#valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt ./tb &&
#cat valgrind-out.txt | grep -A 4 "LEAK SUMMARY"