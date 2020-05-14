#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "! C alloc C sized:"
./csized/run.sh

echo ""

echo "! VHDL sized:"
./vhdlsized/run.sh

#echo ""

#echo "! VHDL Package sized:" #fails under windows, so call separately in linux tests.
#./vhdlpkgsized/run.sh