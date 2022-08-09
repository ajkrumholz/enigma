# A CLI runner for Codecracker

require_relative 'lib/code_cracker'

code_cracker = CodeCracker.new

read_file = File.open(ARGV[0], 'r')
encrypted_message = read_file.read
read_file.close

cracked = code_cracker.crack(encrypted_message)

write_file = File.open(ARGV[1], 'w')
write_file.write(cracked[:decryption])
write_file.close

puts "created #{ARGV[1]} with the cracked key #{cracked[:key]} and date #{cracked[:date]}"
