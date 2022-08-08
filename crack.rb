require_relative 'lib/enigma'

enigma = Enigma.new

read_file = File.open(ARGV[0], 'r')

encrypted_message = read_file.read { |f| }

cracked = enigma.crack(encrypted_message, enigma.dategen)
decryption = cracked[:decryption]

write_file = File.open(ARGV[1], 'w')
write_file.write(decryption)

puts "created #{ARGV[1]} with the cracked key #{decryption[:key]} and date #{enigma.dategen}"