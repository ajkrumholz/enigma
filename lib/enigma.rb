require_relative 'enigma_helper'
require 'date'


class Enigma
  include Cryptable

  def initialize

  end

  def encrypt(message, key = keygen, date = dategen)
    final_offsets = generate_final_offsets(key, date)
    output = []
      message.downcase.split("").each do |character|
      if character_set.include?(character)
        ch_index = character_set.index(character)
        output << character_set.rotate(final_offsets[0])[ch_index]
        final_offsets.rotate!(1)
      else
        output << character
      end
    end
    encrypt_out(output, key, date)
  end

  def decrypt(message, key = keygen, date = dategen)
    final_offsets = generate_final_offsets(key, date)
    output = []
      message.downcase.split("").each do |character|
      if character_set.include?(character)
        ch_index = character_set.index(character)
        output << character_set.rotate(-(final_offsets[0]))[ch_index]
        final_offsets.rotate!(1)
      else
        output << character
      end
    end
    decrypt_out(output, key, date)
  end
end
