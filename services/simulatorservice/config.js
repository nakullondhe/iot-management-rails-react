module.exports = {
  mqttOptions: {
    host: '8865d5d4a5f8489992db0282c9e20e37.s1.eu.hivemq.cloud',
    port: 8883,
    protocol: 'mqtts',
    username: process.env.USERNAME,
    password: process.env.PASSWORD
  },
  brokerName: 'HiveMQ',
  devices: [
    { deviceId: 1, interval: 1000, upper: 15, lower: 9, unit: '°C' },
    { deviceId: 2, interval: 2000, upper: 25, lower: 18, unit: '°C' },
    { deviceId: 3, interval: 3000, upper: 60, lower: 50, unit: 'km/hr' },
  ]
}