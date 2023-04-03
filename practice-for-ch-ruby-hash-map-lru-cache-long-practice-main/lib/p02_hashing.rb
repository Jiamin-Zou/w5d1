class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    # s_arr = self.map{ |ele| ele.hash.to_s}
    # s_arr.join.hash

    h = 0
    self.each_with_index do |ele ,i|
      sum = ele.hash + i.hash
      h ^= sum
    end
    h
  end
end

class String
  def hash
    self.bytes.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    h = 0
    self.each do |k, v|
      sum = k.hash + v.hash
      h ^= sum
    end
    h
  end
end