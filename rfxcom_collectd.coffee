require 'require-yaml'
RfxCom = require 'rfxcom'
Collectd = require 'collectdout'

config = require './config.yml'
console.log config

rfxtrx = new RfxCom.RfxCom config.rfxcom.usb#, debug: true
client = new Collectd config.collectd.interval, config.collectd.host, config.collectd.port


sensors = {}
for probe, values of config.probes
  sensors[values.id] = name: values.name, \
    temperature: 0.0, \
    humidity: 0, \
    batteryLevel: 0, \
    plugin: client.plugin 'rfxcom', probe

rfxtrx.on "th1", (evt) ->
  # console.log evt
  sensors[evt.id].temperature = evt.temperature
  sensors[evt.id].humidity = evt.humidity
  sensors[evt.id].batteryLevel = evt.batteryLevel
  # console.log sensors[evt.id]

rfxtrx.initialise () -> 
  console.log "Device initialized"

setInterval () ->
  for sensor_id, values of sensors
    values.plugin.setGauge 'temperature', 'temperature', values.temperature
    values.plugin.setGauge 'humidity', 'humidity', values.humidity
    values.plugin.setGauge 'gauge', 'batteryLevel', values.batteryLevel
    # console.log "sent temperature %d, humidity %d, batteryLevel %d for probe %s", values.temperature, values.humidity, values.batteryLevel, sensor_id
, config.collectd.interval
