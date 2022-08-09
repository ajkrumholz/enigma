# Decryptor is a machine built to decrypt messages using a date and key to determine the original encryption pattern

require_relative 'cryptable'
require 'date'

class Decryptor
  include Cryptable

  attr_reader :today_date,
              :character_set

  def initialize
    @today_date = Date.today.strftime('%d%m%y')
    @character_set = ('a'..'z').to_a << ' '
  end

  def decrypt(message, key, date = @today_date)
    final_offsets = generate_final_offsets(key, date)
    message = message.downcase.split('')
    output = message.map do |character|
      build_decrypt_array(character, output, final_offsets)
    end
    decrypt_out(output, key, date)
  end

  def build_decrypt_array(character, _output, final_offsets)
    if @character_set.include?(character)
      ch_index = @character_set.index(character)
      new_character = decrypt_character(final_offsets, ch_index)
      final_offsets.rotate!
      new_character
    else
      character
    end
  end

  def decrypt_character(final_offsets, ch_index)
    @character_set.rotate(-final_offsets.first)[ch_index]
  end
  
  def decrypt_out(output, key, date)
    {
      decryption: output.join(''),
      key: key,
      date: date
    }
  end
end
