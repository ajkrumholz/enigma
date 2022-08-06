module Cryptable

  def character_set
    ("a".."z").to_a << " "
  end

  def keygen
    @key = (Array.new(5) { rand(0..9) }).join
  end

  def dategen
    Date.today.strftime("%d%m%y")
  end

  def key_hash(key)
    { 
      a: key[0..1],
      b: key[1..2],
      c: key[2..3],
      d: key[3..4]
    }
  end

  def offset_hash(date)
    sq_date = date.to_i ** 2
    {
      a: sq_date.to_s[-4],
      b: sq_date.to_s[-3],
      c: sq_date.to_s[-2],
      d: sq_date.to_s[-1]
    }
  end

  def generate_final_offsets(key, date)
    keys = key_hash(key)
    offsets = offset_hash(date)
    [
      keys[:a].to_i + offsets[:a].to_i,
      keys[:b].to_i + offsets[:b].to_i,
      keys[:c].to_i + offsets[:c].to_i,
      keys[:d].to_i + offsets[:d].to_i
    ]
  end
  
  def build_encrypt_array(character, output, final_offsets)
    if character_set.include?(character)
      ch_index = character_set.index(character)
      output << character_set.rotate(final_offsets[0])[ch_index]
      final_offsets.rotate!(1)
    else
      output << character
    end
  end
  
  def build_decrypt_array(character, output, final_offsets)
    if character_set.include?(character)
      ch_index = character_set.index(character)
      output << character_set.rotate(-(final_offsets[0]))[ch_index]
      final_offsets.rotate!(1)
    else
      output << character
    end
  end

  def encrypt_out(output, key, date)
    {
      encryption: output.join(""),
      key: key,
      date: date
    }
  end
  
  def decrypt_out(output, key, date)
    {
      decryption: output.join(""),
      key: key,
      date: date
    }
  end
end