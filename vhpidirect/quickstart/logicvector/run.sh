#!/usr/bin/env sh

cd "$(dirname $0)"

set -e

ghdl -a tb.vhd
ghdl -e -Wl,-I./ -Wl,main.c tb &&
./tb
#valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt ./tb &&
#cat valgrind-out.txt | grep -A 4 "LEAK SUMMARY"
