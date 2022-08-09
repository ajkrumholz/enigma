require_relative 'lib/enigma'

enigma = Enigma.new
read_file = File.open(ARGV[0], 'r')

encrypted_message = read_file.read
read_file.close
require 'pry'; binding.pry

cracked = enigma.crack(encrypted_message.to_s)
decryption = cracked[:decryption]

write_file = File.open(ARGV[1], 'w')
write_file.write(decryption)
write_file.close

puts "created #{ARGV[1]} with the cracked key #{cracked[:key]} and date #{enigma.dategen}"
