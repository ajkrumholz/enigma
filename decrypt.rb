# A CLI runner for Decryptor

require_relative 'lib/decryptor'

decryptor = Decryptor.new

read_file = File.open(ARGV[0], 'r')
encrypted_message = read_file.read { |f| }
read_file.close

decryption = decryptor.decrypt(encrypted_message, ARGV[2], ARGV[3])

write_file = File.open(ARGV[1], 'w')
write_file.write(decryption[:decryption])
write_file.close

puts "created #{ARGV[1]} with the key #{decryption[:key]} and date #{decryption[:date]}"
