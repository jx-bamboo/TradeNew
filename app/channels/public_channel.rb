# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PublicChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "current connections: #{ActionCable.server.connections.count}"
    puts "PublicChannel subscribed  ===#{params.inspect}"
    stream_from "public"
    #reject_subscription 取消订阅
    PublicJob.perform_now("public",{success: true,code:'200',action: "btcusdt",data: Welcome.list_limit_6})
    PublicJob.perform_now("public",{success: true,code:'200',action: "ethusdt",data: Welcome.list_limit_6('ethusdt')})
  end

  def unsubscribed
    Rails.logger.info "PublicChannel unsubscribed"
    transmit success: { 'code' => 200, 'message' => ('You are reject unsubscription') }
    stop_all_streams
  end
end
