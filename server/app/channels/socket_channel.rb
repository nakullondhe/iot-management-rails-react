class SocketChannel < ApplicationCable::Channel
  def subscribed
    channel_name = params[:channel]
    logger.info "Client subscribed to #{channel_name}"
    logger.info "Client subscribed to SocketChannel"
    
    # Stream data when a client subscribes to the channel
    stream_from 'SocketChannel'
    # ActionCable.server.broadcast('SocketChannel', "Hello from SocketChannel")
  end

  def receive(data)
    logger.info "Client  received message: #{data}"
    ActionCable.server.broadcast('SocketChannel', data)
  end


  def unsubscribed
   
  end
end
