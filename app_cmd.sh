#!/bin/sh
export RAILS_ENV=$RAILS_ENV

bundle exec rake db:create
bundle exec rake db:migrate
exec bundle exec puma -C config/puma.rb -e $RAILS_ENV
