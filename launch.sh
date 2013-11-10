#!/bin/bash
#
# @author holman
#
# Shortcut script to launch Rails web server

# Keep this sync'd with my-config/ports
PROD_PORT=7701

usage() {
  echo "Usage ./launch.sh (dev|prod)"
  exit
}

wrong_dir() {
  echo "Error: run from project root dir"
  exit
}

if [ $# -lt 1 ]; then usage; fi

if [ $1 == 'dev' ]; then
  rails server
elif [ $1 == 'prod' ]; then
  # Migrate db
  rake db:migrate RAILS_ENV=production

  rails server -e production -p $PROD_PORT
else
  usage
fi
