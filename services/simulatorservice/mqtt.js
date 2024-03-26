
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
    let value = Math.random() * (device.upper - device.lower) + device.lower;
    publishMessage(device.deviceId, value, device.unit);
  }, device.interval);

  // Store the function in the map with device ID as key
  deviceFunctionsMap.set(device.deviceId, () => clearInterval(intervalId));
}

client.on('connect', () => {
  console.log(`Connected to ${brokerName} MQTT broker`);

  const deviceFunctionsMap = new Map();

  devices.forEach((device) => {
    let topic = `iot/device/${device.deviceId}`;
    startPublishing(device, deviceFunctionsMap);
  });

  // client.subscribe(topic, (err) => {
  //   if (err) {
  //     console.error('Subscription error:', err);
  //   } else {
  //     console.log(`Subscribed to topic '${topic}'`);
  //   }
  // });


  // publish(client, topic2, 'Hello from MQTT publisher!');
  // console.log(`Published message to topic '${topic}'`);
});

// Handle incoming messages
// client.on('message', (topic, message) => {
//   console.log(`Received message on topic '${topic}': ${message.toString()}`);
// });

// Handle errors
client.on('error', (error) => {
  console.error('MQTT error:', error);
});

module.exports = {
  mqttClient: client
}