module Cryptable

  def character_set
    ("a".."z").to_a << " "
  end

  def keygen
    @key = (Array.new(5) { rand(0..9) }).join
  end

  def dategen
    @date = Date.today.strftime("%d%m%Y")
  end

  def a_key(key)
    key[0..1]
  end

  def b_key(key)
    key[1..2]
  end

  def c_key(key)
    key[2..3]
  end

  def d_key(key)
    key[3..4]
  end

  def a_offset(date)
    date_squared = date.to_i ** 2
    date_squared.to_s[-4]
  end

  def b_offset(date)
    date_squared = date.to_i ** 2
    date_squared.to_s[-3]
  end

  def c_offset(date)
    date_squared = date.to_i ** 2
    date_squared.to_s[-2]
  end

  def d_offset(date)
    date_squared = date.to_i ** 2
    date_squared.to_s[-1]
  end

  def a_final(key, date)
    a_key(key).to_i + a_offset(date).to_i
  end

  def b_final(key, date)
    b_key(key).to_i + b_offset(date).to_i
  end

  def c_final(key, date)
    c_key(key).to_i + c_offset(date).to_i
  end

  def d_final(key, date)
    d_key(key).to_i + d_offset(date).to_i
  end

  def generate_final_offsets(key, date)
    [
       a_final(key, date),  
       b_final(key, date),
       c_final(key, date),    
       d_final(key, date),
    ]
  end
end