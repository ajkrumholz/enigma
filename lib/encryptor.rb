require_relative 'enigma_helper'
require 'date'

class Encryptor
  include Cryptable

  attr_reader :today_date,
              :character_set

  def initialize
    @today_date = Date.today.strftime('%d%m%y')
    @character_set = ('a'..'z').to_a << ' '
  end

  def encrypt(message, key = keygen, date = @today_date)
    final_offsets = generate_final_offsets(key, date)
    message = message.downcase.split('')
    output = message.map do |character|
      build_encrypt_array(character, output, final_offsets)
    end
    encrypt_out(output, key, date)
  end

  def encrypt_out(output, key, date)
    {
      encryption: output.join(''),
      key: key,
      date: date
    }
  end

  def build_encrypt_array(character, _output, final_offsets)
    if @character_set.include?(character)
      ch_index = @character_set.index(character)
      new_character = encrypt_character(final_offsets, ch_index)
      final_offsets.rotate!(1)
      new_character
    else
      character
    end
  end

  def encrypt_character(final_offsets, ch_index)
    @character_set.rotate(final_offsets[0])[ch_index]
  end
end