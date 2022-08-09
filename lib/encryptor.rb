# Encryptor is a machine built to encrypt messages using a provided date and provided or generated key.
# If no date is given, today's date is used as the date of encryption.

require_relative 'cryptable'
require 'date'

class Encryptor
  include Cryptable

  attr_reader :today_date,
              :character_set

  def initialize
    @today_date = Date.today.strftime('%d%m%y')
    @character_set = ('a'..'z').to_a << ' '
  end

  def keygen
    (Array.new(5) { rand(0..9) }).join
  end

  def encrypt(message, key = keygen, date = @today_date)
    final_offsets = generate_final_offsets(key, date)
    message = message.downcase.split('')
    output = message.map do |character|
      build_encrypt_array(character, output, final_offsets)
    end
    encrypt_out(output, key, date)
  end

  def build_encrypt_array(character, _output, final_offsets)
    if @character_set.include?(character)
      ch_index = @character_set.index(character) 
      new_character = encrypt_character(final_offsets, ch_index)
      final_offsets.rotate!
      new_character
    else
      final_offsets.rotate!
      character
    end
  end
  
  def encrypt_character(final_offsets, ch_index)
    @character_set.rotate(final_offsets.first)[ch_index]
  end

  def encrypt_out(output, key, date)
    {
      encryption: output.join(''),
      key: key,
      date: date
    }
  end
end
