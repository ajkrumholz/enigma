require_relative 'lib/enigma'

enigma = Enigma.new

read_file = File.open(ARGV[0], 'r')

encrypted_message = read_file.read { |f| }

decryption_hash = enigma.decrypt(encrypted_message, ARGV[2], ARGV[3])
decryption = decryption_hash[:decryption]

write_file = File.open(ARGV[1], 'w')
write_file.write(decryption)

puts "created #{ARGV[1]} with the key #{ARGV[2]} and date #{ARGV[3]}"
