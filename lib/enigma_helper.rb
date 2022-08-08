module Cryptable
  def character_set
    ('a'..'z').to_a << ' '
  end

  def keygen
    (Array.new(5) { rand(0..9) }).join
  end

  def dategen
    Date.today.strftime('%d%m%y')
  end

  def key_array(key)
    [
      key[0..1].to_i,
      key[1..2].to_i,
      key[2..3].to_i,
      key[3..4].to_i
    ]
  end

  def offset_array(date)
    sq_date = date.to_i**2
    sq_date.to_s[-4..].split("").map do |digit|
      digit.to_i
    end
  end

  def generate_final_offsets(key, date)
    keys = key_array(key)
    offsets = offset_array(date)
    keys.zip(offsets).map(&:sum)
  
    # keys = key_hash(key
    # offsets = offset_hash(date)
    # [
    #   keys[:a].to_i + offsets[:a].to_i,
    #   keys[:b].to_i + offsets[:b].to_i,
    #   keys[:c].to_i + offsets[:c].to_i,
    #   keys[:d].to_i + offsets[:d].to_i
    # ]
  end

  def build_encrypt_array(character, _output, final_offsets)
    if character_set.include?(character)
      ch_index = character_set.index(character)
      new_character = encrypt_character(final_offsets, ch_index)
      final_offsets.rotate!(1)
      new_character
    else
      character
    end
  end

  def encrypt_character(final_offsets, ch_index)
    character_set.rotate(final_offsets[0])[ch_index]
  end

  def build_decrypt_array(character, _output, final_offsets)
    if character_set.include?(character)
      ch_index = character_set.index(character)
      new_character = decrypt_character(final_offsets, ch_index)
      final_offsets.rotate!(1)
      new_character
    else
      character
    end
  end

  def decrypt_character(final_offsets, ch_index)
    character_set.rotate(-(final_offsets[0]))[ch_index]
  end

  def encrypt_out(output, key, date)
    {
      encryption: output.join(''),
      key: key,
      date: date
    }
  end

  def decrypt_out(output, key, date)
    {
      decryption: output.join(''),
      key: key,
      date: date
    }
  end

  def decipher_key(message, date)
    cipher = ' end'.split('')
    offsets = offset_array(date)
    ending = message[-4..].split('')
    rotated_offsets = offsets.rotate(message.length - 4)
    final_possibilities = generate_final_possibilities(ending, cipher, rotated_offsets)
    sanitize(final_possibilities, rotated_offsets, offsets)
    final_keys = generate_final_keys(final_possibilities)
    key_array = generate_key_array(final_keys)
    return_deciphered_key(key_array)
  end

  def sanitize(final_possibilities, rotated_offsets, offsets)
    final_possibilities.each { |array| array.delete_if { |num| num < 0 || num > 99 } }
    final_possibilities.rotate!(rotated_offsets.index(offsets[0]))
  end

  def generate_final_possibilities(ending, cipher, rotated_offsets)
    ending.map do |character|
      cipher_index = character_set.index(cipher[0])
      new_set = character_set.rotate(-(27 - cipher_index))
      total_shift = new_set.index(character)
      final_possible_keys = generate_possible_keys(total_shift, rotated_offsets)
      rotated_offsets.rotate!(1)
      cipher.rotate!(1)
      final_possible_keys
    end
  end

  def generate_possible_keys(total_shift, rotated_offsets)
    [
      total_shift - rotated_offsets[0].to_i,
      total_shift + 27 - rotated_offsets[0].to_i,
      total_shift + 54 - rotated_offsets[0].to_i,
      total_shift + 81 - rotated_offsets[0].to_i,
      total_shift + 108 - rotated_offsets[0].to_i
    ]
  end

  def generate_final_keys(final_possibilities)
    final_possibilities.map { |ary| ary.map { |int| '%02d' % int } }
  end

  def generate_key_array(final_keys)
    key_array = []
    final_keys[0].each do |akey|
      final_keys[1].each do |bkey|
        final_keys[2].each do |ckey|
          final_keys[3].each do |dkey|
            key_array.push(akey, bkey, ckey, dkey) if akey[1] == bkey[0] && bkey[1] == ckey[0] && ckey[1] == dkey[0]
    end; end; end; end
    key_array
  end

  def return_deciphered_key(key_array)
    key_array[0] + key_array[1][1] + key_array[2][1] + key_array[3][1]
  end
end
