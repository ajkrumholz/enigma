module Cryptable

  def keygen
    (Array.new(5) { rand(0..9) }).join
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
    sq_date_ary = sq_date.to_s[-4..].split("")
    sq_date_ary.map { |num| num.to_i }
  end

  def generate_final_offsets(key, date)
    keys = key_array(key)
    offsets = offset_array(date)
    keys.zip(offsets).map(&:sum)
  end
end
