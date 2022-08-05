require_relative 'lib/enigma'

enigma = Enigma.new

read_file = File.open(ARGV[0], 'r')

message = read_file.read { |f| }

encryption_hash = enigma.encrypt(message)
encryption = encryption_hash[:encryption]
key = encryption_hash[:key]
date = encryption_hash[:date]

write_file = File.open(ARGV[1], 'w')
write_file.write(encryption)

puts "created #{ARGV[1]} with the key #{key} and date #{date}"