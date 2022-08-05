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
      build_encrypt_array(character, output, final_offsets)
    end
    encrypt_out(output, key, date)
  end

  def decrypt(message, key = keygen, date = dategen)
    final_offsets = generate_final_offsets(key, date)
    output = []
    message.downcase.split("").each do |character|
      build_decrypt_array(character, output, final_offsets)
    end
    decrypt_out(output, key, date)
  end
end
