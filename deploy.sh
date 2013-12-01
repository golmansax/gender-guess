#!/bin/bash -e
#
# @author holman
#
# Shortcut script to deploy Rails web server

# Keep this sync'd with my-config/ports
PROD_PORT=7701

usage() {
  echo 'Usage ./deploy.sh (dev|prod)'
  exit
}

wrong_dir() {
  echo 'Error: run from project root dir'
  exit
}

if [ $# -lt 1 ]; then usage; fi

git pull
git submodule init
git submodule update

# Make sure Rails packages are installed
bundle install

if [ $1 == 'dev' ]; then
  echo '*** Migrating db ***'
  rake db:migrate

  echo '*** Starting server ***'
  rails server
elif [ $1 == 'prod' ]; then
  echo '*** Migrating db ***'
  rake db:migrate RAILS_ENV=production

  echo '*** Making sure tests pass ***'
  rake test

  echo '*** Compiling assets ***'
  bundle exec rake assets:precompile

  echo '*** Killing server if it is running ***'
  pkill --full rails

  echo '*** Starting server ***'
  rails server -e production -p $PROD_PORT -d
else
  usage
fi
