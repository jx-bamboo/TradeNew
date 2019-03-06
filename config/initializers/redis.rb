require "redis"
require "redis-namespace"
require "redis/objects"
redis_host = SettingRedis.host
redis_port = SettingRedis.port
redis_password = SettingRedis.password.blank? ? nil : SettingRedis.password
redis_db2 = Redis.new(:driver => :hiredis, :host => redis_host, :port => redis_port, :db => 13, password: redis_password)
$redis_export_data = Redis::Namespace.new(Setting.sidekiq.name_space, :redis => redis_db2)