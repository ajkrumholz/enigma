# A CLI runner for Encryptor

require_relative 'lib/encryptor'

encryptor = Encryptor.new

read_file = File.open(ARGV[0], 'r')
message = read_file.read { |f| }
read_file.close

encryption = encryptor.encrypt(message)

write_file = File.open(ARGV[1], 'w')
write_file.write(encryption[:encryption])
write_file.close

puts "created #{ARGV[1]} with the key #{encryption[:key]} and date #{encryption[:date]}"
