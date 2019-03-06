class PublicJob < ApplicationJob
  queue_as :public_notifications

  def perform(channel,data)
  	broadcast(channel,data)
  end
  
end
