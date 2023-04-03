class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self.include?(key)
      @count +=1
      self.resize! if @count > num_buckets
      self[key] << key
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_size = num_buckets * 2
    new_store = Array.new(new_size) {Array.new}
    @store.each do |bucket|
      next if bucket.empty?
      bucket.each do |num|
        new_store[num.hash % new_size] << num
      end
    end
    @store = new_store
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket = num.hash % num_buckets
    @store[bucket]
  end
end