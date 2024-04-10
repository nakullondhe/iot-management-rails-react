
const mqtt = require('mqtt');
const { brokerName, mqttOptions, devices } = require('./config');

// Connect to the MQTT broker
const client = mqtt.connect(mqttOptions);

function publishMessage(deviceId, value, unit) {
  const data = {
    deviceId: deviceId,
    value,
    unit
  };
  const payload = JSON.stringify(data);
  client.publish(`device/measurement/${deviceId}`, payload);
}

function startPublishing(device, deviceFunctionsMap) {
  const intervalId = setInterval(() => {
    let value = Math.floor(Math.random() * (device.upper - device.lower) + device.lower)
    publishMessage(device.deviceId, value, device.unit);
  }, device.interval);

  // Store the function in the map with device ID as key
  deviceFunctionsMap.set(device.deviceId, () => clearInterval(intervalId));
}

client.on('connect', (dt) => {
  console.log(`Connected to ${brokerName} MQTT broker`);

  const deviceFunctionsMap = new Map();

  devices.forEach((device) => {
    let topic = `iot/device/${device.deviceId}`;
    startPublishing(device, deviceFunctionsMap);
  });

});

// Handle errors
client.on('error', (error) => {
  console.error('MQTT error:', error);
});

module.exports = {
  mqttClient: client
}