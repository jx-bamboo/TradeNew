# -*- coding: utf-8 -*-
class SettingRedis < Settingslogic
  source "#{Rails.root}/config/redis.yml"
  namespace Rails.env
  load! if Rails.env.development?

  def self.sidekiq_redis_url
  	if SettingRedis.password.present?
  		"redis://:#{SettingRedis.password}@#{SettingRedis.host}:#{SettingRedis.port}/13/sidekiq_cache"
  	else
  		"redis://#{SettingRedis.host}:#{SettingRedis.port}/13/sidekiq_cache"
  	end
  end
end
