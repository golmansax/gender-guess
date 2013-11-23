#!/bin/bash -e
#
# This recomputes the coeffecients and restarts the Rails server

usage() {
  echo 'Usage ./restart_server.sh (dev|prod)'
  exit
}

if [ $# -lt 1 ]; then usage; fi

# First make the coeffecients
MY_DIR=`dirname $0`
cd $MY_DIR
make
./make_coeffs.byte

# Restart Rails server
cd `git rev-parse --show-toplevel`
pkill --full rails
./launch.sh $1
