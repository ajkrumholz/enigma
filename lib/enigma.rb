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
    #creates an array of characters [" ", "e", "n", "d"]
    cipher = " end".split('')
    #finds the offset values by the last 4 digits of (date ^ 2)
    offsets = offset_hash(date).values
    # offsets_hash = {
    #   a: offsets[0],
    #   b: offsets[1],
    #   c: offsets[2],
    #   d: offsets[3]
    # }
    # creates an array of the last 4 characters in message
    ending = message[-4..-1].split("")
    # rotates the offsets so they line up properly with the last 4 digits, i.e. for messages of different lengths we won't always be working on offset a for the first character of the cipher
    rotated_offsets = offsets.rotate(message.length - 4)
    #initializes a hash of final possible a, b, c, and d keys
    final_possibilities = []
    #iterates through each character in the last 4 of the encrypted method
    ending.each do |character|
      #finds the index of the character in the original char set
      ch_index = character_set.index(character)
      #finds the index of the current cipher char in the original char set
      cipher_index = character_set.index(cipher[0])
      #creates a new char set where current cipher char is at position 0
      new_set = character_set.rotate(-(27-cipher_index))
      #reads position of current char, indicating total shift achieved
      total_shift = new_set.index(character)
      #populates a nested array with possible keys that could have led to the shift we've calculated
      final_possibilities << [
        total_shift - rotated_offsets[0].to_i,
        total_shift + 27 - rotated_offsets[0].to_i,
        total_shift + 54 - rotated_offsets[0].to_i,
        total_shift + 81 - rotated_offsets[0].to_i,
        total_shift + 108 - rotated_offsets[0].to_i
      ]
      #rotates offsets for the next character
      rotated_offsets.rotate!(1)
      #moves on to the next character of the cipher
      cipher.rotate!(1)
    end
    #deletes any results that are less than 0 or greater than 100
    final_possibilities.each { |array| array.delete_if { |num| num < 0 || num > 99 } }
    # returns final_possibilities order to a,b,c,d by comparing offsets with the correct rotation necessary for rotated offsets, which can change based on the length of the original message received
    final_possibilities.rotate!(rotated_offsets.index(offsets[0]))
    #maps variables with integers converted to strings with leading zeroes if necessary
    possible_a_keys = final_possibilities[0].map { |int| "%02d" % int }
    possible_b_keys = final_possibilities[1].map { |int| "%02d" % int }
    possible_c_keys = final_possibilities[2].map { |int| "%02d" % int }
    possible_d_keys = final_possibilities[3].map { |int| "%02d" % int }
    #creates nested arrays of the final possible keys in string form with leading zeroes
    final_keys = [possible_a_keys, possible_b_keys, possible_c_keys, possible_d_keys]
    #initializes an array that will hold keys than match the specified pattern
    key_array = []
    #iterates through all possible keys and checks if they match the patter specified on line 93
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
    #returns a 5-digit string representing the key deciphered using the above pattern
    key_array[0] + key_array[1][1] + key_array[2][1] + key_array[3][1]
  end
end
