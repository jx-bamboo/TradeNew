#! /bin/bash
#chmod 755 deploy.sh
# author: TryCatch
# date:2019-01-19

if [ ! -n "$RAILS_ENV" ]; then
  echo "Please set RAILS_ENV."
else
  echo "=> $RAILS_ENV"
  kill -9 `cat tmp/pids/sidekiq_$RAILS_ENV.pid`
  kill -9 `cat tmp/pids/puma_$RAILS_ENV.pid`
  bundle exec sidekiq -d -C config/sidekiq.yml 
  bundle exec puma -d -e $RAILS_ENV --port 4001 --pidfile tmp/pids/puma_$RAILS_ENV.pid
fi
