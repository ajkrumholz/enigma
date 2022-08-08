require_relative 'enigma_helper'
require 'date'

class Enigma
  include Cryptable

  def encrypt(message, key = keygen, date = dategen)
    final_offsets = generate_final_offsets(key, date)
    message = message.downcase.split('')
    output = message.map do |character|
      build_encrypt_array(character, output, final_offsets)
    end
    encrypt_out(output, key, date)
  end

  def decrypt(message, key, date = dategen)
    final_offsets = generate_final_offsets(key, date)
    message = message.downcase.split('')
    output = message.map do |character|
      build_decrypt_array(character, output, final_offsets)
    end
    decrypt_out(output, key, date)
  end

  def crack(message, date = dategen)
    key = decipher_key(message, date)
    decrypt(message, key, date)
  end
end
