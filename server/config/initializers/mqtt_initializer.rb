# config/initializers/mqtt_initializer.rb

Rails.application.config.after_initialize do
  begin 
  init_mqtt
  rescue StandardError => e
    Rails.logger.error "Error connecting to MQTT broker: #{e.message}"
  end
end

def init_mqtt
  mqtt_service = MqttClient.new
  mqtt_service.connect
  mqtt_service.subscribe

  mqtt_service.listen_for_messages

  # Gracefully disconnect from MQTT broker when Rails server shuts down
  at_exit do
    begin
      mqtt_service.disconnect
    rescue StandardError => e
      Rails.logger.error "Error disconnecting from MQTT broker: #{e.message}"
    end
  end
end
