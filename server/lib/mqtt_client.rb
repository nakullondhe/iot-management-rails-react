class MqttClient
  def initialize
    @client = MQTT::Client.connect(
    :host => '8865d5d4a5f8489992db0282c9e20e37.s1.eu.hivemq.cloud',
    :port => 8883,        
    :username => ENV['USERNAME'],     
    :password => ENV['PASSWORD'] , 
    :ssl => true
    )
    @mqtt_logger = Logger.new("#{Rails.root}/log/mqtt.log")
  end

  def connect
    @client.connect
    @mqtt_logger.info 'Connected to MQTT broker'
  rescue StandardError => e
    @mqtt_logger.error "MQTT connection error: #{e.message}"
  end

  def subscribe()
    devices = [1,2,3]
    devices.each do |deviceId|
      @client.subscribe("device/measurement/#{deviceId}")
      @mqtt_logger.info "Subscribed to topic : device/measurement/#{deviceId}"
    end
  rescue StandardError => e
    @mqtt_logger.error "MQTT subscription error: #{e.message}"
  end

  def listen_for_messages(&block)
    Thread.new do
      begin
        @client.get do |topic, message|
          message = JSON.parse(message)
          @mqtt_logger.info "Received message on topic '#{topic}': #{message["deviceId"]}"

          # device_id = topic.split('/')[2]
          @client.publish("device/ticker/#{message["deviceId"]}", message.to_json)
          
          yield(topic, message) if block_given?
        end
      rescue StandardError => e
        @mqtt_logger.error "MQTT listen error: #{e.message}"
      end
    end
  end

  def disconnect
    @client.disconnect
    @mqtt_logger.info 'Disconnected from MQTT broker'
  rescue StandardError => e
    @mqtt_logger.error "MQTT disconnection error: #{e.message}"
  end
end