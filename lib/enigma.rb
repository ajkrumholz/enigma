require_relative 'enigma_helper'
require 'date'


class Enigma
  include Cryptable

  # def initialize(message = "", key = "", date = "")
  #   @message = ""
  #   @key = ""
  #   @date = ""
  #   # @final_offsets = []
  # end
  
  # def self.generate
  #   Enigma.new(@message, keygen, dategen)
  # end

  def encrypt(message, key = keygen, date = dategen)
    final_offsets = generate_final_offsets(key, date)
    output = []
      message.split("").each do |character|
      if character_set.include?(character)
        ch_index = character_set.index(character)
        output << character_set.rotate(final_offsets[0])[ch_index]
        final_offsets.rotate!(1)
      else
        output << character
      end
    end
    {
      encryption: output.join(""),
      key: key,
      date: date
    }
  end

  def decrypt(message, key = keygen, date = dategen)
    final_offsets = generate_final_offsets(key, date)
    output = []
      message.split("").each do |character|
      if character_set.include?(character)
        ch_index = character_set.index(character)
        output << character_set.rotate(-(final_offsets[0]))[ch_index]
        final_offsets.rotate!(1)
      else
        output << character
      end
    end
    {
      decryption: output.join(""),
      key: key,
      date: date
    }
  end

  



  
end
