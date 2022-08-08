require_relative 'lib/enigma'

enigma = Enigma.new

read_file = File.open(ARGV[0], 'r')

encrypted_message = read_file.read { |f| }
read_file.close

decryption_hash = enigma.decrypt(encrypted_message, ARGV[2], ARGV[3])
decryption = decryption_hash[:decryption]

write_file = File.open(ARGV[1], 'w')
write_file.write(decryption)
write_file.close

puts "created #{ARGV[1]} with the key #{ARGV[2]} and date #{ARGV[3]}"
