# 这里的地址和端口号(1643)都需要配置成正确的

# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://127.0.0.1:6379/0'} #标准格式 config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://127.0.0.1:6379/0'} #标准格式 config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace }
#   schedule_file = "config/sidekiq_schedule.yml"
#   if File.exists?(schedule_file) && Sidekiq.server?
#     Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
#   end
# end

require "redis"
require "redis-namespace"
require "redis/objects"
Sidekiq.configure_client do |config|
  config.redis = { url: SettingRedis.sidekiq_redis_url, namespace: Setting.sidekiq.name_space , network_timeout: 5}
end
Sidekiq.options[:poll_interval] = 1
Sidekiq.configure_server do |config|
  config.redis = { url: SettingRedis.sidekiq_redis_url, namespace: Setting.sidekiq.name_space , network_timeout: 5}
  schedule_file = "config/sidekiq_schedule.yml"
  if File.exists?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end
