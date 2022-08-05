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

  def crack(message, date = dategen)
    key = decipher_key(message, date)
    decrypt(message, key, date)
  end

  def decipher_key(message, date)
    cipher = " end".split('')
    offsets = offset_hash(date).values
    offsets_hash = {
      a: offsets[0],
      b: offsets[1],
      c: offsets[2],
      d: offsets[3]
    }
    ending = message[-4..-1].split("")
    rotated_offsets = offsets.rotate(message.length - 4)
    final_possibilities = []
    
    ending.each do |character|
      ch_index = character_set.index(character)
      cipher_index = character_set.index(cipher[0])
      new_set = character_set.rotate(-(27-cipher_index))
      total_shift = new_set.index(character)
      final_possibilities << [
        total_shift - rotated_offsets[0].to_i,
        total_shift + 27 - rotated_offsets[0].to_i,
        total_shift + 54 - rotated_offsets[0].to_i,
        total_shift + 81 - rotated_offsets[0].to_i,
        total_shift + 108 - rotated_offsets[0].to_i
      ]
      rotated_offsets.rotate!(1)
      cipher.rotate!(1)
    end
    final_possibilities.each { |array| array.delete_if { |num| num < 0 || num > 99 } }
    # returns final_possibilities order to a,b,c,d by comparing offsets with the correct rotation necessary for rotated offsets, which can change based on the length of the original message received
    final_possibilities.rotate!(rotated_offsets.index(offsets[0]))
    possible_a_keys = final_possibilities[0].map { |int| "%02d" % int }
    possible_b_keys = final_possibilities[1].map { |int| "%02d" % int }
    possible_c_keys = final_possibilities[2].map { |int| "%02d" % int }
    possible_d_keys = final_possibilities[3].map { |int| "%02d" % int }
    final_keys = [possible_a_keys, possible_b_keys, possible_c_keys, possible_d_keys]
    key_array = []
    possible_a_keys.each do |akey|
      possible_b_keys.each do |bkey|
        possible_c_keys.each do |ckey|
          possible_d_keys.each do |dkey|
            if akey[1] == bkey[0] && bkey[1] == ckey[0] && ckey[1] == dkey[0]
              key_array.push(akey, bkey, ckey, dkey)
            end
          end
        end
      end
    end
    key_array[0] + key_array[1][1] + key_array[2][1] + key_array[3][1]
  end
end
