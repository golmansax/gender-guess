#!/bin/bash -e
#
# @author holman
#
# Shortcut script to launch Rails web server

# Keep this sync'd with my-config/ports
PROD_PORT=7701

usage() {
  echo 'Usage ./launch.sh (dev|prod)'
  exit
}

wrong_dir() {
  echo 'Error: run from project root dir'
  exit
}

if [ $# -lt 1 ]; then usage; fi

bundle install

if [ $1 == 'dev' ]; then
  # Migrate db
  rake db:migrate

  rails server
elif [ $1 == 'prod' ]; then
  # Migrate db
  echo '*** Migrating db ***'
  rake db:migrate RAILS_ENV=production

  # Make sure tests pass
  echo '*** Making sure tests pass ***'
  rake test

  echo '*** Starting server ***'
  rails server -e production -p $PROD_PORT -d
else
  usage
fi
