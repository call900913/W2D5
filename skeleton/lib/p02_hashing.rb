class Fixnum
  # Fixnum#hash already implemented for you
end



=begin

=end

class Array
  def hash
    return 1.hash + 2.hash if empty?
    self.map.with_index do |val, idx|
      val.hash + (val * (idx+1)).hash
    end.reduce(:+)

  end
end
# 'act' => ['a', 'c', 't'].has
# 'cat' => ['c', 'a', 't']
class String
  def hash
    chars.map.with_index do |char, idx|
      (char.ord * 48611).hash + (char.ord * (idx + 1)).hash
    end
         .reduce(:+)
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_sum = 0

    each do |k, v|
      hash_sum += k.hash + v.hash
    end

    hash_sum
  end
end
