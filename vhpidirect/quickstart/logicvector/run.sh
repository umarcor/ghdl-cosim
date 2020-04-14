#!/usr/bin/env sh

cd "$(dirname $0)"

set -e

ghdl -a --std=08 -O0 -g tb.vhd
ghdl -e --std=08 -O0 -g -Wl,-ggdb3 -Wl,-I./ -Wl,main.c tb &&
./tb
#valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt ./tb &&
#cat valgrind-out.txt | grep -A 4 "LEAK SUMMARY"
