class ApplicationJob < ActiveJob::Base
	def broadcast channel,data
    ActionCable.server.broadcast(channel,data)
  end
end
