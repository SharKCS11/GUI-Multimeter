require "arduino_firmata"

print "Connecting..."
ard = ArduinoFirmata.connect
puts "Connection successful: Firmata version #{ard.version}"

puts "Reading voltage for 100 seconds."
100.times do
    val = ard.analog_read 1
    val = val * (5.0/1024.0) * 2
    puts "Voltage: #{val.round(2)}"
    sleep 1
end