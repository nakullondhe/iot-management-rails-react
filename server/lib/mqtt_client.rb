class MqttClient
  def initialize
    @client = MQTT::Client.connect(
      :host => "8865d5d4a5f8489992db0282c9e20e37.s1.eu.hivemq.cloud",
      :port => 8883,
      :username => ENV["USERNAME"],
      :password => ENV["PASSWORD"],
      :ssl => true,
    )
    @mqtt_logger = Logger.new("#{Rails.root}/log/mqtt.log")
    @redis = Redis.new
  end

  def connect
    @client.connect
    @mqtt_logger.info "Connected to MQTT broker"
  rescue StandardError => e
    @mqtt_logger.error "MQTT connection error: #{e.message}"
  end

  def subscribe()
    devices = [1, 2, 3]
    devices.each do |deviceId|
      @client.subscribe("device/measurement/#{deviceId}")
      @mqtt_logger.info "Subscribed to topic : device/measurement/#{deviceId}"
    end
  rescue StandardError => e
    @mqtt_logger.error "MQTT subscription error: #{e.message}"
  end

  def listen_for_messages(&block) # rubocop:disable Metrics/MethodLength
    Thread.new do
      begin
        @client.get do |topic, message|
          handle_message(topic, message, &block)
        end
      rescue StandardError => e
        @mqtt_logger.error "MQTT listen error: #{e.message}"
      end
    end
  end

  def handle_message(topic, message)
    message = JSON.parse(message)
    @mqtt_logger.info "Received message on topic '#{topic}': #{message}"
    
    is_alarm = @redis.get("device/#{message["deviceId"]}/#{message["value"]}")

    if is_alarm == "1"
      update_alarm(message)
    end

    yield(topic, message) if block_given?
  end

  def update_alarm(message)
    @mqtt_logger.info "Device-Threshold-Alarm | Device: #{message['deviceId']} Value: #{message['value']}"
    alarm = Alarm.find_by(device_id: message['deviceId'], threshold: message['value'])
    alarm.update(triggered: 1)
    alarm.save
    @redis.del("device/#{message['deviceId']}/#{message['value']}")
    @client.publish("alarm/triggered", "#{message['deviceId']}/#{message['threshold']}")
  end

  def publish(topic, message)
    @client.publish(topic, message)
  end

  def disconnect
    @client.disconnect
    @mqtt_logger.info "Disconnected from MQTT broker"
  rescue StandardError => e
    @mqtt_logger.error "MQTT disconnection error: #{e.message}"
  end
end
